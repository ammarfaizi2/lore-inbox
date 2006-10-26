Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423586AbWJZPyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423586AbWJZPyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423589AbWJZPyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:54:52 -0400
Received: from webserve.ca ([69.90.47.180]:53945 "EHLO computersmith.org")
	by vger.kernel.org with ESMTP id S1423586AbWJZPyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:54:51 -0400
Message-ID: <4540DA23.7060104@wintersgift.com>
Date: Thu, 26 Oct 2006 08:54:11 -0700
From: teunis <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: teunis <teunis@wintersgift.com>, linux-kernel@vger.kernel.org,
       art@usfltd.com, Jiri Slaby <jirislaby@gmail.com>,
       Jeff Dike <jdike@addtoit.com>, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: 2.6.19-rc3: known unfixed regressions: confirmations
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061024202104.GF27968@stusta.de> <453E8921.2090406@wintersgift.com> <20061026153142.GJ27968@stusta.de>
In-Reply-To: <20061026153142.GJ27968@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian Bunk wrote:
> On Tue, Oct 24, 2006 at 02:44:01PM -0700, teunis wrote:
>> Adrian Bunk wrote:
>>> This email lists some known unfixed regressions in 2.6.19-rc3 compared 
>>> to 2.6.18.
>> ...
>>
>> I'm not directly testing -rc3 as yet...  rc2-mm2 + a few modifications
>> works on the equipment I'm testing and as I can't afford more lost time
>> due to faults - I'm keeping to that build for the short term.
>>
>>> Subject    : shutdown problem
>>> References : http://lkml.org/lkml/2006/10/22/140
>>> Submitter  : art@usfltd.com
>>>              teunis@wintersgift.com
>>>              Jiri Slaby <jirislaby@gmail.com>
>>> Status     : unknown
>> repaired by Jeff Dike's patch to fs/proc/array.c
>> ...
> 
> Can you give me a pointer to this patch?
> 
> cu
> Adrian
> 

I have no idea how to look up the link any other way - so here's a copy
of the details from my mailbox (I've been keeping an archive local as I
frequently work offline)

posted by: akpm@osdl.org; 23/10/06 10:34 AM

From: Jeff Dike <jdike@addtoit.com>

add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch
in -mm causes UML to hang at shutdown - init is sitting in a select on the
initctl socket.

This patch fixes it for me.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
- ---

 fs/proc/array.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN
fs/proc/array.c~add-process_session-helper-routine-deprecate-old-field-fix-warnings-fix
fs/proc/array.c
- ---
a/fs/proc/array.c~add-process_session-helper-routine-deprecate-old-field-fix-warnings-fix
+++ a/fs/proc/array.c
@@ -388,7 +388,7 @@ static int do_task_stat(struct task_stru
 			stime = cputime_add(stime, sig->stime);
 		}

- -		signal_session(sig);
+		sid = signal_session(sig);
 		pgid = process_group(task);
 		ppid = rcu_dereference(task->real_parent)->tgid;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFQNojbFT/SAfwLKMRAqioAJ9+l+87bNRFJaHknJBGu6bYfrTlrACeOyts
gkeCAiYDPBmR7E052LEMAtU=
=eyIw
-----END PGP SIGNATURE-----
