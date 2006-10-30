Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWJ3T6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWJ3T6G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWJ3T6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:58:05 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:18864 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932475AbWJ3T6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:58:04 -0500
Message-ID: <45465948.6010902@comcast.net>
Date: Mon, 30 Oct 2006 14:58:00 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Avoidable floating point save/restore?
References: <45462036.5070104@comcast.net> <45464D86.2030503@cfl.rr.com>
In-Reply-To: <45464D86.2030503@cfl.rr.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ah, okay.  That still leaves me wtf'ing at the stuff on comp.os.minix
but maybe what you said is what they meant.  ;)

Phillip Susi wrote:
> The FP registers only need to be saved/restored if one or both of the
> current task and the task being switched to have made use of them ( i.e.
> they ever do FP or MMX math ).  Initially FP access is disabled and the
> first time a task tries to use the FPU, a fault is triggered and the
> kernel enables the FPU for that task and sets a flag so it remembers it
> needs to save/restore the state when switching in/out of that task.
> 
> 
> John Richard Moser wrote:
> I found this from comp.os.minix (actually part of a MINIX FAQ):
> 
> =====CUT=====
> From: kjb=733301@cs.vu.nl (Kees J Bot)
> Subject: Re: MMX/3DNow support was RE: MINIX Development?
> Date: Wed, 23 Jul 2003 20:15:03 +0200
> 
> This is really a hardware floating point issue, because the MMX
> registers share the FP registers. This was done so that MMX unaware OSen
> can still support MMX programs, because when they save and restore the
> FP registers then the MMX state is also saved and restored if that
> happens to be what the FP registers are used for. This saving and
> restoring is what Minix doesn't do. So if two processes use FP/MMX then
> a context switch from one to the other will clobber the FP state of
> both. What is needed to make this work is a trap handler that reacts to
> the use of FP, so that Minix can save the FP state of the process that
> last used FP and load the FP state of the current process. On a context
> switch Minix merely sets the "don't use FP" bit in some register. Costs?
> One FP interrupt handler, some FP save/restore/setup code, some memory
> per process to store the FP state into, and some memory to store the FP
> state when a user process catches a signal. (Not sure about the signal
> business, much check with Philip.) This isn't much work, we can simply
> take Minix-vmd's code, but I haven't seen any need yet. Minix has to use
> software FP as distributed, or it won't run on your old 386, so Minix
> itself doesn't need it. Anyone here who wants to use Minix for some
> heavy number crunching? If so then I could be persuaded to add an
> ENABLE_FPU to the next release, by default off. I don't care about MMX,
> that's way too exotic for Minix.
> =====CUT=====
> 
> I'm trying to make heads or tails about what in the heck is going on
> here.  It looks like they're saying you don't need to save/restore FP
> registers between context switches unless one process uses FP and the
> other uses MMX; but that doesn't make ANY sense at all.  If
> gnome-session divides 3.14/2.28 and then gimp divides 3.33/2.22 and then
> we switch BACK to gnome-session and it wants to divide the result by
> 1.92, wouldn't we need the FPU registers back in the exact state they
> were at before switching away?
> 
- -

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRUZZRgs1xW0HCTEFAQJgeBAAlxMT3Sh4Bhq9Kp7bCEVLv/aGJSSBDVBe
C/3KkU7u+CWX/Hbxhm1wiuIlWQ9PMKAFWArdZSM8TBUGa6No8e6HKhNOqfXDTUFA
JkEpdQaewVcIK8PhPyS8cPu4DA+I7+3R3B0RKAhbDZTc8uyoG2jMwMNgmFMqGmGe
+q50YuKVDP2iE7HuDCV5Ae1KLdL1VspXCZqOl0mmbPIhV89Lp2I2VZIbOhcq4oYx
lWnUB7xACuWzdGP4kVIxGcZb9rqFOyJWTyaBwPuzcYQs7TVNFPRYCNoV++Rsv2BJ
M576LILPOvxaJv6ticsia8r02HuEF4Yh1ZcArCuhO6wbJ3gjmCdynpea0dh46/Xx
OzmAGnXeLgM+erNgP8ZT9m2SAtSpsYfx2gbbafcpQVk3UcnX0Z+l/DpfDDurdnHt
zL2koT04M5HXSriicBB94BBtBZk09pXWvqQ26CJ3/vPHnNK1JDJwL6kW1kX2sWuc
7+rs2HRCTZIa2O+uaPgw8ZrlunuqCgV5oueZhpH1BHa2JjIExD0QrhhGUMMXIlyT
xD54ghFFk/tndtAdwVR12S8mukQdkSUTxa8aHWqyoVS3XIe860bLuocyVrMGtdBs
VYXNqz3dGFQhj5vpcYAaGPzKlTSDyzGQtubd9mWfqVjZ1HLZYcD+eozpXAtEIAIR
lKdlVNqpqME=
=uZ51
-----END PGP SIGNATURE-----
