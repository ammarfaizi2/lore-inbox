Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWEVToB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWEVToB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWEVToB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:44:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:56996 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751158AbWEVToA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:44:00 -0400
Message-ID: <44721469.5000601@fr.ibm.com>
Date: Mon, 22 May 2006 21:43:37 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, xemul@sw.ru, haveblue@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 4/9] namespaces: utsname: switch to using uts namespaces
References: <20060518154700.GA28344@sergelap.austin.ibm.com>	<20060518154936.GE28344@sergelap.austin.ibm.com> <20060518170234.07c8fe4c.rdunlap@xenotime.net>
In-Reply-To: <20060518170234.07c8fe4c.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------030408010604000400080706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030408010604000400080706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Randy.Dunlap wrote:
> On Thu, 18 May 2006 10:49:36 -0500 Serge E. Hallyn wrote:
> 
>> Replace references to system_utsname to the per-process uts namespace
>> where appropriate.  This includes things like uname.
>>
>> Changes: Per Eric Biederman's comments, use the per-process uts namespace
>> 	for ELF_PLATFORM, sunrpc, and parts of net/ipv4/ipconfig.c
>>
>> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
>>
>> ---
>>
>> 9ee063adf4d2287583dbb0a71d1d5f80d7ae011f
>> diff --git a/arch/i386/kernel/sys_i386.c b/arch/i386/kernel/sys_i386.c
>> index 8fdb1fb..4af731d 100644
>> --- a/arch/i386/kernel/sys_i386.c
>> +++ b/arch/i386/kernel/sys_i386.c
>> @@ -210,7 +210,7 @@ asmlinkage int sys_uname(struct old_utsn
>>  	if (!name)
>>  		return -EFAULT;
>>  	down_read(&uts_sem);
>> -	err=copy_to_user(name, &system_utsname, sizeof (*name));
>> +	err=copy_to_user(name, utsname(), sizeof (*name));
> 
> It would be really nice if you would fix spacing while you are here,
> like a space a each side of '='.
> 
> and a space after ',' in the function calls below.

Here's a possible cleanup on top of serge's patchset as found in
2.6.17-rc4-mm3.

C.




--------------030408010604000400080706
Content-Type: text/x-patch;
 name="fix-spacing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-spacing.patch"

Subject: [PATCH] namespaces : fix spacing
From: Cedric Le Goater <clg@fr.ibm.com>

This patch fixes some spacing issues

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---
 arch/i386/kernel/sys_i386.c   |   27 ++++++++++++++++-----------
 arch/m32r/kernel/sys_m32r.c   |    2 +-
 arch/mips/kernel/linux32.c    |    2 +-
 arch/mips/kernel/syscall.c    |   25 +++++++++++++++----------
 arch/parisc/hpux/sys_hpux.c   |   25 +++++++++++++++----------
 arch/sh/kernel/sys_sh.c       |    2 +-
 arch/sh64/kernel/sys_sh64.c   |    2 +-
 arch/sparc/kernel/sys_sunos.c |   15 ++++++++++-----
 arch/um/kernel/syscall_kern.c |   22 +++++++++++-----------
 arch/x86_64/ia32/sys_ia32.c   |   23 ++++++++++++-----------
 fs/cifs/connect.c             |    2 +-
 kernel/sys.c                  |    2 +-
 12 files changed, 85 insertions(+), 64 deletions(-)

Index: 2.6.17-rc4-mm3/arch/i386/kernel/sys_i386.c
===================================================================
--- 2.6.17-rc4-mm3.orig/arch/i386/kernel/sys_i386.c
+++ 2.6.17-rc4-mm3/arch/i386/kernel/sys_i386.c
@@ -210,7 +210,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, utsname(), sizeof (*name));
+	err = copy_to_user(name, utsname(), sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
@@ -226,16 +226,21 @@
   
   	down_read(&uts_sem);
 	
-	error = __copy_to_user(&name->sysname,&utsname()->sysname,__OLD_UTS_LEN);
-	error |= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename,&utsname()->nodename,__OLD_UTS_LEN);
-	error |= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release,&utsname()->release,__OLD_UTS_LEN);
-	error |= __put_user(0,name->release+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version,&utsname()->version,__OLD_UTS_LEN);
-	error |= __put_user(0,name->version+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine,&utsname()->machine,__OLD_UTS_LEN);
-	error |= __put_user(0,name->machine+__OLD_UTS_LEN);
+	error = __copy_to_user(&name->sysname, &utsname()->sysname,
+			       __OLD_UTS_LEN);
+	error |= __put_user(0, name->sysname + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->nodename, &utsname()->nodename,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->nodename + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->release, &utsname()->release,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->release + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->version, &utsname()->version,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->version + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->machine, &utsname()->machine,
+				__OLD_UTS_LEN);
+	error |= __put_user(0, name->machine + __OLD_UTS_LEN);
 	
 	up_read(&uts_sem);
 	
Index: 2.6.17-rc4-mm3/arch/m32r/kernel/sys_m32r.c
===================================================================
--- 2.6.17-rc4-mm3.orig/arch/m32r/kernel/sys_m32r.c
+++ 2.6.17-rc4-mm3/arch/m32r/kernel/sys_m32r.c
@@ -206,7 +206,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, utsname(), sizeof (*name));
+	err = copy_to_user(name, utsname(), sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
Index: 2.6.17-rc4-mm3/arch/mips/kernel/linux32.c
===================================================================
--- 2.6.17-rc4-mm3.orig/arch/mips/kernel/linux32.c
+++ 2.6.17-rc4-mm3/arch/mips/kernel/linux32.c
@@ -1040,7 +1040,7 @@
 	int ret = 0;
 
 	down_read(&uts_sem);
-	if (copy_to_user(name,utsname(),sizeof *name))
+	if (copy_to_user(name, utsname(), sizeof *name))
 		ret = -EFAULT;
 	up_read(&uts_sem);
 
Index: 2.6.17-rc4-mm3/arch/mips/kernel/syscall.c
===================================================================
--- 2.6.17-rc4-mm3.orig/arch/mips/kernel/syscall.c
+++ 2.6.17-rc4-mm3/arch/mips/kernel/syscall.c
@@ -249,16 +249,21 @@
 	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
 		return -EFAULT;
 
-	error = __copy_to_user(&name->sysname,&utsname()->sysname,__OLD_UTS_LEN);
-	error -= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->nodename,&utsname()->nodename,__OLD_UTS_LEN);
-	error -= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->release,&utsname()->release,__OLD_UTS_LEN);
-	error -= __put_user(0,name->release+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->version,&utsname()->version,__OLD_UTS_LEN);
-	error -= __put_user(0,name->version+__OLD_UTS_LEN);
-	error -= __copy_to_user(&name->machine,&utsname()->machine,__OLD_UTS_LEN);
-	error = __put_user(0,name->machine+__OLD_UTS_LEN);
+	error = __copy_to_user(&name->sysname, &utsname()->sysname,
+			       __OLD_UTS_LEN);
+	error -= __put_user(0, name->sysname + __OLD_UTS_LEN);
+	error -= __copy_to_user(&name->nodename, &utsname()->nodename,
+				__OLD_UTS_LEN);
+	error -= __put_user(0, name->nodename + __OLD_UTS_LEN);
+	error -= __copy_to_user(&name->release, &utsname()->release,
+				__OLD_UTS_LEN);
+	error -= __put_user(0, name->release + __OLD_UTS_LEN);
+	error -= __copy_to_user(&name->version, &utsname()->version,
+				__OLD_UTS_LEN);
+	error -= __put_user(0, name->version + __OLD_UTS_LEN);
+	error -= __copy_to_user(&name->machine, &utsname()->machine,
+				__OLD_UTS_LEN);
+	error = __put_user(0, name->machine + __OLD_UTS_LEN);
 	error = error ? -EFAULT : 0;
 
 	return error;
Index: 2.6.17-rc4-mm3/arch/parisc/hpux/sys_hpux.c
===================================================================
--- 2.6.17-rc4-mm3.orig/arch/parisc/hpux/sys_hpux.c
+++ 2.6.17-rc4-mm3/arch/parisc/hpux/sys_hpux.c
@@ -266,16 +266,21 @@
 
 	down_read(&uts_sem);
 
-	error = __copy_to_user(&name->sysname,&utsname()->sysname,HPUX_UTSLEN-1);
-	error |= __put_user(0,name->sysname+HPUX_UTSLEN-1);
-	error |= __copy_to_user(&name->nodename,&utsname()->nodename,HPUX_UTSLEN-1);
-	error |= __put_user(0,name->nodename+HPUX_UTSLEN-1);
-	error |= __copy_to_user(&name->release,&utsname()->release,HPUX_UTSLEN-1);
-	error |= __put_user(0,name->release+HPUX_UTSLEN-1);
-	error |= __copy_to_user(&name->version,&utsname()->version,HPUX_UTSLEN-1);
-	error |= __put_user(0,name->version+HPUX_UTSLEN-1);
-	error |= __copy_to_user(&name->machine,&utsname()->machine,HPUX_UTSLEN-1);
-	error |= __put_user(0,name->machine+HPUX_UTSLEN-1);
+	error = __copy_to_user(&name->sysname, &utsname()->sysname,
+			       HPUX_UTSLEN - 1);
+	error |= __put_user(0, name->sysname + HPUX_UTSLEN - 1);
+	error |= __copy_to_user(&name->nodename, &utsname()->nodename,
+				HPUX_UTSLEN - 1);
+	error |= __put_user(0, name->nodename + HPUX_UTSLEN - 1);
+	error |= __copy_to_user(&name->release, &utsname()->release,
+				HPUX_UTSLEN - 1);
+	error |= __put_user(0, name->release + HPUX_UTSLEN - 1);
+	error |= __copy_to_user(&name->version, &utsname()->version,
+				HPUX_UTSLEN - 1);
+	error |= __put_user(0, name->version + HPUX_UTSLEN - 1);
+	error |= __copy_to_user(&name->machine, &utsname()->machine,
+				HPUX_UTSLEN - 1);
+	error |= __put_user(0, name->machine + HPUX_UTSLEN - 1);
 
 	up_read(&uts_sem);
 
Index: 2.6.17-rc4-mm3/arch/sh/kernel/sys_sh.c
===================================================================
--- 2.6.17-rc4-mm3.orig/arch/sh/kernel/sys_sh.c
+++ 2.6.17-rc4-mm3/arch/sh/kernel/sys_sh.c
@@ -267,7 +267,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, utsname(), sizeof (*name));
+	err = copy_to_user(name, utsname(), sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
Index: 2.6.17-rc4-mm3/arch/sh64/kernel/sys_sh64.c
===================================================================
--- 2.6.17-rc4-mm3.orig/arch/sh64/kernel/sys_sh64.c
+++ 2.6.17-rc4-mm3/arch/sh64/kernel/sys_sh64.c
@@ -279,7 +279,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, utsname(), sizeof (*name));
+	err = copy_to_user(name, utsname(), sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
Index: 2.6.17-rc4-mm3/arch/sparc/kernel/sys_sunos.c
===================================================================
--- 2.6.17-rc4-mm3.orig/arch/sparc/kernel/sys_sunos.c
+++ 2.6.17-rc4-mm3/arch/sparc/kernel/sys_sunos.c
@@ -483,13 +483,18 @@
 {
 	int ret;
 	down_read(&uts_sem);
-	ret = copy_to_user(&name->sname[0], &utsname()->sysname[0], sizeof(name->sname) - 1);
+	ret = copy_to_user(&name->sname[0], &utsname()->sysname[0],
+			   sizeof(name->sname) - 1);
 	if (!ret) {
-		ret |= __copy_to_user(&name->nname[0], &utsname()->nodename[0], sizeof(name->nname) - 1);
+		ret |= __copy_to_user(&name->nname[0], &utsname()->nodename[0],
+				      sizeof(name->nname) - 1);
 		ret |= __put_user('\0', &name->nname[8]);
-		ret |= __copy_to_user(&name->rel[0], &utsname()->release[0], sizeof(name->rel) - 1);
-		ret |= __copy_to_user(&name->ver[0], &utsname()->version[0], sizeof(name->ver) - 1);
-		ret |= __copy_to_user(&name->mach[0], &utsname()->machine[0], sizeof(name->mach) - 1);
+		ret |= __copy_to_user(&name->rel[0], &utsname()->release[0],
+				      sizeof(name->rel) - 1);
+		ret |= __copy_to_user(&name->ver[0], &utsname()->version[0],
+				      sizeof(name->ver) - 1);
+		ret |= __copy_to_user(&name->mach[0], &utsname()->machine[0],
+				      sizeof(name->mach) - 1);
 	}
 	up_read(&uts_sem);
 	return ret ? -EFAULT : 0;
Index: 2.6.17-rc4-mm3/arch/um/kernel/syscall_kern.c
===================================================================
--- 2.6.17-rc4-mm3.orig/arch/um/kernel/syscall_kern.c
+++ 2.6.17-rc4-mm3/arch/um/kernel/syscall_kern.c
@@ -110,7 +110,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, utsname(), sizeof (*name));
+	err = copy_to_user(name, utsname(), sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
@@ -126,21 +126,21 @@
   
   	down_read(&uts_sem);
 	
-	error = __copy_to_user(&name->sysname,&utsname()->sysname,
+	error = __copy_to_user(&name->sysname, &utsname()->sysname,
 			       __OLD_UTS_LEN);
-	error |= __put_user(0,name->sysname+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename,&utsname()->nodename,
+	error |= __put_user(0, name->sysname + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->nodename, &utsname()->nodename,
 				__OLD_UTS_LEN);
-	error |= __put_user(0,name->nodename+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release,&utsname()->release,
+	error |= __put_user(0, name->nodename + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->release, &utsname()->release,
 				__OLD_UTS_LEN);
-	error |= __put_user(0,name->release+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version,&utsname()->version,
+	error |= __put_user(0, name->release + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->version, &utsname()->version,
 				__OLD_UTS_LEN);
-	error |= __put_user(0,name->version+__OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine,&utsname()->machine,
+	error |= __put_user(0, name->version + __OLD_UTS_LEN);
+	error |= __copy_to_user(&name->machine, &utsname()->machine,
 				__OLD_UTS_LEN);
-	error |= __put_user(0,name->machine+__OLD_UTS_LEN);
+	error |= __put_user(0, name->machine + __OLD_UTS_LEN);
 	
 	up_read(&uts_sem);
 	
Index: 2.6.17-rc4-mm3/arch/x86_64/ia32/sys_ia32.c
===================================================================
--- 2.6.17-rc4-mm3.orig/arch/x86_64/ia32/sys_ia32.c
+++ 2.6.17-rc4-mm3/arch/x86_64/ia32/sys_ia32.c
@@ -796,25 +796,26 @@
 
 	if (!name)
 		return -EFAULT;
-	if (!access_ok(VERIFY_WRITE,name,sizeof(struct oldold_utsname)))
+	if (!access_ok(VERIFY_WRITE, name, sizeof(struct oldold_utsname)))
 		return -EFAULT;
   
   	down_read(&uts_sem);
 	
-	error = __copy_to_user(&name->sysname,&utsname()->sysname,__OLD_UTS_LEN);
-	 __put_user(0,name->sysname+__OLD_UTS_LEN);
-	 __copy_to_user(&name->nodename,&utsname()->nodename,__OLD_UTS_LEN);
-	 __put_user(0,name->nodename+__OLD_UTS_LEN);
-	 __copy_to_user(&name->release,&utsname()->release,__OLD_UTS_LEN);
-	 __put_user(0,name->release+__OLD_UTS_LEN);
-	 __copy_to_user(&name->version,&utsname()->version,__OLD_UTS_LEN);
-	 __put_user(0,name->version+__OLD_UTS_LEN);
+	error = __copy_to_user(&name->sysname, &utsname()->sysname,
+			       __OLD_UTS_LEN);
+	 __put_user(0, name->sysname + __OLD_UTS_LEN);
+	 __copy_to_user(&name->nodename, &utsname()->nodename, __OLD_UTS_LEN);
+	 __put_user(0, name->nodename + __OLD_UTS_LEN);
+	 __copy_to_user(&name->release, &utsname()->release, __OLD_UTS_LEN);
+	 __put_user(0, name->release + __OLD_UTS_LEN);
+	 __copy_to_user(&name->version, &utsname()->version, __OLD_UTS_LEN);
+	 __put_user(0, name->version + __OLD_UTS_LEN);
 	 { 
 		 char *arch = "x86_64";
 		 if (personality(current->personality) == PER_LINUX32)
 			 arch = "i686";
 		 
-		 __copy_to_user(&name->machine,arch,strlen(arch)+1);
+		 __copy_to_user(&name->machine, arch, strlen(arch) + 1);
 	 }
 	
 	 up_read(&uts_sem);
@@ -830,7 +831,7 @@
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err=copy_to_user(name, utsname(), sizeof (*name));
+	err = copy_to_user(name, utsname(), sizeof (*name));
 	up_read(&uts_sem);
 	if (personality(current->personality) == PER_LINUX32) 
 		err |= copy_to_user(&name->machine, "i686", 5);
Index: 2.6.17-rc4-mm3/fs/cifs/connect.c
===================================================================
--- 2.6.17-rc4-mm3.orig/fs/cifs/connect.c
+++ 2.6.17-rc4-mm3/fs/cifs/connect.c
@@ -765,7 +765,7 @@
 	separator[1] = 0; 
 
 	memset(vol->source_rfc1001_name,0x20,15);
-	for(i=0;i < strnlen(utsname()->nodename,15);i++) {
+	for(i = 0; i < strnlen(utsname()->nodename, 15); i++) {
 		/* does not have to be a perfect mapping since the field is
 		informational, only used for servers that do not support
 		port 445 and it can be overridden at mount time */
Index: 2.6.17-rc4-mm3/kernel/sys.c
===================================================================
--- 2.6.17-rc4-mm3.orig/kernel/sys.c
+++ 2.6.17-rc4-mm3/kernel/sys.c
@@ -1676,7 +1676,7 @@
 	int errno = 0;
 
 	down_read(&uts_sem);
-	if (copy_to_user(name,utsname(),sizeof *name))
+	if (copy_to_user(name, utsname(), sizeof *name))
 		errno = -EFAULT;
 	up_read(&uts_sem);
 	return errno;

--------------030408010604000400080706--
