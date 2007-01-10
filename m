Return-Path: <linux-kernel-owner+w=401wt.eu-S964814AbXAJLKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbXAJLKR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 06:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbXAJLKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 06:10:16 -0500
Received: from smtp3.guam.net ([202.128.0.48]:58723 "EHLO smtp3.guam.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964814AbXAJLKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 06:10:14 -0500
X-Greylist: delayed 1135 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2007 06:10:14 EST
From: "Michael D. Setzer II" <mikes@kuentos.guam.net>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Date: Wed, 10 Jan 2007 20:50:53 +1000
MIME-Version: 1.0
Subject: Re: bug: depca_module_init() cleanup error
Message-ID: <45A551AD.28893.9250C24@mikes.kuentos.guam.net>
In-reply-to: <20061218152713.GA16208@elte.hu>
References: <20061218152713.GA16208@elte.hu>
X-PM-Encryptor: QDPGP, 4
X-mailer: Pegasus Mail for Windows (4.41)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Wondering if there has been any update on this problem. I'm also getting a 
kernel panic when I include the DEPCA nic in the build. Without it, the latest 
git kernel works, but with it I get the panic. I am working on a new version of 
the g4l project, and the latest kernels are working with some hardware that 
the older ones don't, but this this fails, and I have at least 1 user that has this 
nic. I've been getting about 9000 downloads per month on the project, so 
would like to get it working. It does work with some of the older kernels on 
the iso, but if a user has this nic and hardware that requires the newer 
kernel.


On 18 Dec 2006 at 16:27, Ingo Molnar wrote:

Date sent:      	Mon, 18 Dec 2006 16:27:13 +0100
From:           	Ingo Molnar <mingo@elte.hu>
To:             	linux-kernel@vger.kernel.org
Copies to:      	Andrew Morton <akpm@osdl.org>
Subject:        	bug: depca_module_init() cleanup error

> 
> while doing an allyesconfig bootup on a PC the depca driver triggered 
> the crash below.
> 
> 	Ingo
> 
> ------------------>
> Calling initcall 0xc1ea0506: depca_module_init+0x0/0xd7()
> PM: Adding info for platform:depca.0
> depca: probe of depca.0 failed with error -16
> PM: Removing info for platform:depca.0
> kfree_debugcheck: out of range ptr 300h.
> BUG at mm/slab.c:2910!
> stopped custom tracer.
> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:2910!
> invalid opcode: 0000 [#1]
> PREEMPT SMP 
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c0194367>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.19.1-rt16 #494)
> EIP is at kfree_debugcheck+0x52/0xa9
> eax: 0000001a   ebx: 00040000   ecx: c01356a9   edx: 00000001
> esi: 00000300   edi: 00000300   ebp: f7c21ec4   esp: f7c21eb0
> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
> Process swapper (pid: 1, ti=f7c21000 task=f7c30c50 task.ti=f7c21000)
> Stack: c14f9371 c150c05d 00000b5e f772aea0 c1fd4ea0 f7c21ee8 c01953b2 00000300 
>        fffffff0 f772b080 00000000 f772aea0 f772b080 c1902880 f7c21ef8 c06e3d0e 
>        00000300 c19029f0 f7c21f0c c06dfcd9 f772aea8 c06dfe6e f772b080 f7c21f28 
> Call Trace:
>  [<c0106273>] show_trace_log_lvl+0x34/0x4a
>  [<c0106332>] show_stack_log_lvl+0xa9/0xb9
>  [<c010663e>] show_registers+0x1f5/0x290
>  [<c0106a3b>] die+0x1de/0x2db
>  [<c13deb95>] do_trap+0xac/0xca
>  [<c0106f73>] do_invalid_op+0xae/0xb8
>  [<c13de8a1>] error_code+0x39/0x40
>  [<c01953b2>] kfree+0x42/0xce
>  [<c06e3d0e>] platform_device_release+0x1e/0x38
>  [<c06dfcd9>] device_release+0x36/0x6b
>  [<c04f091c>] kobject_cleanup+0x4d/0x74
>  [<c04f095a>] kobject_release+0x17/0x19
>  [<c04f0f7a>] kref_put+0x5b/0x69
>  [<c04f02b6>] kobject_put+0x24/0x26
>  [<c06dfe6e>] put_device+0x1d/0x1f
>  [<c06e3cee>] platform_device_put+0x1b/0x1d
>  [<c1ea0598>] depca_module_init+0x92/0xd7
>  [<c0100567>] init+0x178/0x451
>  [<c0105feb>] kernel_thread_helper+0x7/0x10
>  =======================
> Code: 24 e7 c3 50 c1 e8 00 17 fa ff e8 49 08 fd ff c7 44 24 08 5e 0b 00 00 c7 44 24 04 5d c0 50 c1 c7 04 24 71 93 4f c1 e8 df 16 fa ff <0f> 0b 5e 0b 5d c0 50 c1 6b c3 74 03 05 10 f2 35 c2 8b 00 84 c0 
> EIP: [<c0194367>] kfree_debugcheck+0x52/0xa9 SS:ESP 0068:f7c21eb0
>  <0>Kernel panic - not syncing: Attempted to kill init!
>  [<c0106273>] show_trace_log_lvl+0x34/0x4a
>  [<c01063a9>] show_trace+0x2c/0x2e
>  [<c01063d6>] dump_stack+0x2b/0x2d
>  [<c0134c93>] panic+0x67/0x124
>  [<c0137a0d>] do_exit+0xb8/0x9ed
>  [<c0106b30>] die+0x2d3/0x2db
>  [<c13deb95>] do_trap+0xac/0xca
>  [<c0106f73>] do_invalid_op+0xae/0xb8
>  [<c13de8a1>] error_code+0x39/0x40
>  [<c01953b2>] kfree+0x42/0xce
>  [<c06e3d0e>] platform_device_release+0x1e/0x38
>  [<c06dfcd9>] device_release+0x36/0x6b
>  [<c04f091c>] kobject_cleanup+0x4d/0x74
>  [<c04f095a>] kobject_release+0x17/0x19
>  [<c04f0f7a>] kref_put+0x5b/0x69
>  [<c04f02b6>] kobject_put+0x24/0x26
>  [<c06dfe6e>] put_device+0x1d/0x1f
>  [<c06e3cee>] platform_device_put+0x1b/0x1d
>  [<c1ea0598>] depca_module_init+0x92/0xd7
>  [<c0100567>] init+0x178/0x451
>  [<c0105feb>] kernel_thread_helper+0x7/0x10
>  =======================
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


+----------------------------------------------------------+
  Michael D. Setzer II -  Computer Science Instructor      
  Guam Community College  Computer Center                  
  mailto:mikes@kuentos.guam.net                            
  mailto:msetzerii@gmail.com
  http://www.guam.net/home/mikes
  Guam - Where America's Day Begins                        
+----------------------------------------------------------+

http://setiathome.berkeley.edu
Number of Seti Units Returned:  19,471
Processing time:  32 years, 290 days, 12 hours, 58 minutes
(Total Hours: 287,489)

BOINC TOTAL CREDITS SETI@HOME/EINSTEIN@HOME
Total Credits 2594674.848944 
Total Credits 409969.475419 


-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8 -- QDPGP 2.61c
Comment: http://community.wow.net/grt/qdpgp.html

iQA/AwUBRaQ4byzGQcr/2AKZEQIFQACcDWfQjg3zQzaQmf6JSN+wGv5AgMgAoOJA
O9rEXo5qioAqvO+tRTkHyTI8
=jWMQ
-----END PGP SIGNATURE-----
