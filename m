Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132049AbRCYHAx>; Sun, 25 Mar 2001 02:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132055AbRCYHAn>; Sun, 25 Mar 2001 02:00:43 -0500
Received: from owns.warpcore.org ([216.81.249.18]:13755 "EHLO
	owns.warpcore.org") by vger.kernel.org with ESMTP
	id <S132049AbRCYHAi>; Sun, 25 Mar 2001 02:00:38 -0500
Date: Sun, 25 Mar 2001 00:58:23 -0600
From: Stephen Clouse <stephenc@theiqgroup.com>
To: Stephen Satchell <satch@fluent-access.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010325005823.A32589@owns.warpcore.org>
In-Reply-To: <00d801c0b4bb$e7a04be0$0201a8c0@cybercable.fr> <4.3.2.7.2.20010324214339.00b228a0@mail.fluent-access.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.2.5i
In-Reply-To: <4.3.2.7.2.20010324214339.00b228a0@mail.fluent-access.com>; from satch@fluent-access.com on Sat, Mar 24, 2001 at 09:45:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, Mar 24, 2001 at 09:45:01PM -0800, Stephen Satchell wrote:
> If you have a mission-critical application running on your box, add it to 
> the inittab file with the RESPAWN attribute.  That way, OOM killer kills 
> it, init notices it, and init restarts your server.

Ah, that's great for simple daemons.  Now tell me how to help an app like this 
(Oracle exampled here):

oracle      89  0.0  0.4 41076 1776 ?        S    Mar22   0:00 ora_pmon_slash
oracle      91  0.0  0.6 40676 2620 ?        S    Mar22   0:00 ora_dbw0_slash
oracle      93  0.0  0.4 40544 1788 ?        S    Mar22   0:00 ora_lgwr_slash
oracle      95  0.0  0.4 40544 1744 ?        S    Mar22   0:00 ora_ckpt_slash
oracle      97  0.0  1.1 40556 4404 ?        S    Mar22   0:00 ora_smon_slash
oracle      99  0.0  0.5 40536 2188 ?        S    Mar22   0:00 ora_reco_slash
oracle     101  0.0  0.4 40656 1756 ?        S    Mar22   0:00 ora_arc0_slash

In this example, when oom_kill reaps one of these autonomous threads, Oracle 
opts to crash and burn.  Database corruption is almost guaranteed.

In all reality, I'm sure any daemon (threads or no) that works heavily with disk
files is likely to screw itself and its data if it gets sigkilled for no
reason.  And in our environment, there is no reason for it to get sigkilled.

I'm going to severely hurt the first person that says such a program should be
*expecting* random untrappable annihilation of its threads.  (And what happens
when the master process *is* the target?)

- -- 
Stephen Clouse <stephenc@theiqgroup.com>
Senior Programmer, IQ Coordinator Project Lead
The IQ Group, Inc. <http://www.theiqgroup.com/>

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8

iQA/AwUBOr2XDgOGqGs0PadnEQK0rACfQELDid11+m90bS/DrGyrsHW45ZEAn19G
mL3fSCdi2TeHDxGLA8uXT8l5
=oQPV
-----END PGP SIGNATURE-----
