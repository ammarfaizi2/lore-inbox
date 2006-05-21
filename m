Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWEUXkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWEUXkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 19:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWEUXkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 19:40:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50135 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751422AbWEUXkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 19:40:07 -0400
To: Sam Vilain <sam@vilain.net>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org,
       ebiederm@xmission.com, xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 1/9] namespaces: add nsproxy
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518154837.GB28344@sergelap.austin.ibm.com>
	<4470F7FD.4030608@vilain.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 21 May 2006 17:38:27 -0600
In-Reply-To: <4470F7FD.4030608@vilain.net> (Sam Vilain's message of "Mon, 22
 May 2006 11:30:05 +1200")
Message-ID: <m11wunne30.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> writes:

> Serge E. Hallyn wrote:
>
>>@@ -1585,7 +1591,15 @@ asmlinkage long sys_unshare(unsigned lon
>> 
>> 	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist) {
>> 
>>+		old_nsproxy = current->nsproxy;
>>+		new_nsproxy = dup_namespaces(old_nsproxy);
>>+		if (!new_nsproxy) {
>>+			err = -ENOMEM;
>>+			goto bad_unshare_cleanup_semundo;
>>+		}
>>+
>> 		task_lock(current);
>>  
>>
>
> We'll get lots of duplicate nsproxy structures before we move all of the
> pointers for those subsystems into it. Do we need to dup namespaces on
> all of those conditions?

Ugh.  Good catch.  The new nsproxy needs to be just for the fs and the uts
namespace.  

I guess that means that test should be moved up a few lines.

Eric
