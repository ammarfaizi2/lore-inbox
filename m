Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVFVR3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVFVR3Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVFVRWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:22:55 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:58638 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261800AbVFVRTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:19:33 -0400
To: ericvh@gmail.com
CC: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
In-reply-to: <a4e6962a05062209486115ec@mail.gmail.com> (message from Eric Van
	Hensbergen on Wed, 22 Jun 2005 11:48:00 -0500)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
	 <20050622004902.796fa977.akpm@osdl.org>
	 <E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
	 <20050622021251.5137179f.akpm@osdl.org>
	 <E1Dl1Oz-0007Dq-00@dorka.pomaz.szeredi.hu>
	 <20050622024423.66d773f3.akpm@osdl.org>
	 <E1Dl20U-0007Ic-00@dorka.pomaz.szeredi.hu>
	 <a4e6962a0506220523791a31da@mail.gmail.com>
	 <E1Dl85I-0007nR-00@dorka.pomaz.szeredi.hu> <a4e6962a05062209486115ec@mail.gmail.com>
Message-Id: <E1Dl8sZ-0007tG-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jun 2005 19:19:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's related to the problem of a suid program accessing synthetic
> > filesystem, and filesystem doing something bad to suid program (make
> > it hang, supply bogus data ...).  This can be solved by "squashing"
> > suid for the whole namespace (basically the Plan 9 solution).
> > Unfortunately this is not really practical in Linux/Unix.
> > 
> 
> Just to make sure I understand you - if I don't squash suid for the
> entire name space, a user could mount a malicious synthetic (even with
> NOSUID) and then launch an SUID app from an inherited mount which
> would then traverse to the malicious synthetic.

Yes. 

> That's a nasty case I hadn't considered before -- however, what's the
> potential damage there?  The user could hold up progress of the SUID
> app that they launched, but that wouldn't necessarily impede system
> progress since system-critical suid apps wouldn't be typically
> launched by a user.  I suppose there is the possibility that if
> multiple instances of such an SUID app share a global lock you could
> get into trouble -- do we have any concrete example apps that would
> exhibit this kind of behavior?

I don't know any.  But with 'sudo' the potential set of SUID apps is
basically infinite, so you'd have a hard time proving that this sort
of situation won't arise.

> Are there other vunerabilities that I'm missing?

Another theoretical possibility is that you make the SUID app consume
some resource by feeding it a large-file/deep-directory/etc that quota
would otherwise prevent (you can't do quota on a synthetic filesystem,
without the filesystem's cooperation).

Miklos
