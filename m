Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282906AbRLMKhN>; Thu, 13 Dec 2001 05:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282190AbRLMKgu>; Thu, 13 Dec 2001 05:36:50 -0500
Received: from mail1.upco.es ([130.206.70.227]:37464 "HELO mail1.upco.es")
	by vger.kernel.org with SMTP id <S281818AbRLMKgi>;
	Thu, 13 Dec 2001 05:36:38 -0500
Date: Thu, 13 Dec 2001 11:36:16 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: linux-kernel@vger.kernel.org
Subject: User-manageable sub-ids proposals
Message-ID: <20011213113616.B6547@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C1678ED.8090805@namesys.com> <20011212204333.A4017@pimlott.ne.mediaone.net> <3C1873A2.1060702@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1873A2.1060702@namesys.com>; from reiser@namesys.com on Thu, Dec 13, 2001 at 12:23:46PM +0300
X-Edited-With-Muttmode: muttmail.sl - 2000-11-20 - RGtti 2001-01-29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning to everyone.

I was thinking about the idea of sub-ids to enable users to run "untrusted"
binary or "dangerous" one without risk for their files/privacy. 

I had an idea to a low-profile, almost no invasive way to implement it that
should be almost transparent to user-space application (almost all). Let me
explain with an example. 

Let's add to task_struct another array like groups[NGROUPS], calling it
slave_uids[NSLAVES]. Add a (privileged) syscall, addslave(uid_t, uid_t), 
that can fill that arrays.

Now, the user space configuration is the following: 

I am romano, uid 300.
There is(/are) another(s) user, for example r-slave, uid 3001, no login
shell, with home dir in ~romano/r-slave.

When I login as romano, the login binary call a addslave(300, 3001), looking
at a /etc/slaves that has a line that says romano:r-slave

Now change the kernel so that: 

1) user romano can do a setuid() call to become anyone of its slaves, with
   no way back possible. 

2) user romano can chown() files owned by him and by any of its slaves to
   any of the romano or slaves uids. 

And that's all. All the other strange file management that user romano would
want to do on the slave-id environment, he can do by doing a kind-of-su(*)
to one of its slaves (with setuid) and then play in the restricted
enviroment. If you add ACL to this(**), you could easily fine-control what the
untrusted binary can see of your environment; add the per-vfsmount ro-flag
and it gives to you a lot of flexibility. 

This should be a change simple enough for the kernel, and for the userspace
too: just change login to add addslave call, and the tools that need to
spawn untrusted binaries can do a setuid() to a slave before the exec(). 

Is there something that I am missing here? 

                 Romano 


(*) probably to be called giu... (sorry, Italian-speaking only joke: /su/
means 'up' in Italian, and /giu/ means 'down'). 

(**) and without ACL, if you makes a parallel thing for gid, you can
probably fine-tune access in the old-style ways, provided that the system
set-up is the "every user in its own group" style.


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 411 132
