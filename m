Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317938AbSGVXoG>; Mon, 22 Jul 2002 19:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317940AbSGVXoF>; Mon, 22 Jul 2002 19:44:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:44464 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317938AbSGVXoE>;
	Mon, 22 Jul 2002 19:44:04 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFFA78CFD9.0A163DA3-ON85256BFE.006743B1@pok.ibm.com>
From: "Ben Rafanello" <benr@us.ibm.com>
Date: Mon, 22 Jul 2002 18:47:05 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 07/22/2002 07:47:07 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 11:23:42 Joe Thornber wrote:
>On Thu, Jul 18, 2002 at 12:49:21AM -0400, Guillaume Boissiere wrote:
>> o EVMS (Enterprise Volume Management System)      (EVMS team)
>> o LVM (Logical Volume Manager) v2.0               (LVM team)
>
>Some comments on the 'EVMS vs LVM2' threads:
>
>I am only petitioning for the driver called 'device-mapper' to be
>included in the kernel.  This is a *much* lower level volume manager
>than either the EVMS or LVM1 drivers.  I am *not* petitioning for EVMS
>not to be included.
>
My position is similar - I would like to see EVMS in the kernel.  I
certainly would not mind seeing device mapper go into the kernel as
well.  EVMS was designed to appeal to the corporate user and to play
in the enterprise computing environment.  The goal was to make Linux
more attractive to users in this environment, and this determined much
of its look and feel, as well as its feature set.  However, enterprise
computing is just one of the environments where Linux is found.  While
what we have done to appeal to the enterprise user will be attractive
to other users as well, it is not a 'one size fits all' solution.
Similarly, Device Mapper appeals to a certain set of users and
applications as well.  Given this, I think that both should be included.

>People are getting understandably confused between device-mapper and
>LVM2:>
>
>*) device-mapper is a driver, intended to provide an extensible (via
>   the definition of new targets) framework capable of support
>   *anything* that volume management applications should want to do.
>

Are you working with Jeff Garzik?  It sounds like he is working on
something similar to device mapper for partition management.

>*) LVM2 is a userland application that uses the device-mapper driver to
>   provide a set of tools very similar to LVM1.  Currently LVM2 is the
>   only userland application that uses this driver, leading people to
>   associate the two far too strongly.
>
>It would be good if other volume managers embrace device-mapper
>allowing us to work together on the kernel side, and compete in
>userland.

Having multiple volume managers use device mapper, each without
being aware of the others, will lead to chaos.  This is why EVMS
is designed the way it is - so that we can safely have multiple
user interfaces/volume managers coexist.  This is where the real
work is.

>Kernel development takes *far* too much manpower for us to
>be duplicating work.

Our experience has been a little different - the kernel code was the
least of our worries.  The userspace code has been far more taxing ...

>For example I released the LVM2 vs EVMS snapshot
>benchmarks in the hope of encouraging EVMS to move over to
>device-mapper,

This is much easier said than done.

>unfortunately 2 months later a reply is posted stating
>that they have now developed equivalent (but broken) code :(

To say that our code is broken is not technically correct.  We
designed our async snapshot code with a different set of priorities
based upon the desires of our target audience.  Maximum performance
was deemed more important than the integrity of the snapshot across
a system crash as long as snapshot integrity is maintained across
clean shutdowns.  The code performs as advertised and is not
broken.  What you have an issue with is the design priorities we
followed when creating this version of async snapshots (we have
another version in the works which I think you may like better).

BTW, our performance team has been trying to get LVM2/Device Mapper
to work on some benchmarks so that they can complete their performance
work comparing LVM2/device mapper snapshots against EVMS snapshots.
In the performance results that were posted to this mailing list on
Fri, 12 Jul 2002 18:21:08 by Andrew Theurer <habanero@us.ibm.com>,
you will notice several DNFs.  Here we have LVM2/Device Mapper code
which is NOT working in accordance with its design, and is therefore
a better match for the term "broken".  The point here is that
LVM2/EVMS/Device Mapper are not perfect and there is little to be
gained by throwing stones at each other.

>
>Sistina and IBM *are* both competing with their volume managers, but I
>feel that this competition should be occuring in userland - and
>certainly is not relevant to this list.  For instance EVMS appears to
>do Volume + FS management whereas LVM2 does just volume management -
>in no way does device-mapper preclude FS management, yet that is the
>impression that some of the postings to the list have been giving.
>
>- Joe


Ben Rafanello
EVMS Team Lead
IBM Linux Technology Center
(512) 838-4762
benr@us.ibm.com


