Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSF0Aos>; Wed, 26 Jun 2002 20:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316666AbSF0Aor>; Wed, 26 Jun 2002 20:44:47 -0400
Received: from cubert.attheoffice.org ([216.62.240.170]:1764 "EHLO
	cubert.attheoffice.org") by vger.kernel.org with ESMTP
	id <S316663AbSF0Aoq>; Wed, 26 Jun 2002 20:44:46 -0400
Subject: Re: [PATCH] /proc/scsi/map
From: Nick Bellinger <nickb@attheoffice.org>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <3D18AD30.7040904@pacbell.net>
References: <Pine.LNX.4.33.0206250920150.8496-100000@geena.pdx.osdl.net> 
	<3D18AD30.7040904@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 26 Jun 2002 17:39:19 -0600
Message-Id: <1025134761.15055.84.camel@subjeKt>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-25 at 11:49, David Brownell wrote:
> >>Why shouldn't there be a $DRIVERFS/net/ipv4@10.42.135.99/... style
> >>hookup for iSCSI devices?  Using whatever physical addressing the
> >>kernel uses there, which I assume wouldn't necessarily be restricted
> >>to ipv4.  (And not exposing physical network topology -- routing! --
> >>in driverfs.)
> > 
> > 
> > You can very well use driverfs to expose those attributes, and is one of 
> > the things that we've been discussing at the kernel summit. driverfs will 
> > take over the world. But, I still think the device is best represented as 
> > a child of the phsysical network device. 
> 
> Which one?  I'd certainly hope that drivers wouldn't have to choose which
> of the various network interfaces to register under, or register under
> every network interface concurrently.  (Or only the ones they might
> conceivably be routed to go out on...)  Given a bonded network link (going
> out over multiple physical drivers) that'd get hairy.  And what about
> devices that host several logical interfaces?  Or when the interfaces get
> moved to some other device?

I hate to kick the already deceased horse but..  

This appears to be one of the larger problems that nobody (aside from
this thread :) seems to be raising.  I understand Pat's logic of wanting
to keep the logical device a child of the network card,  but in many
situations (espically the enterprise ones with regard multipathed IP
storage, along with David's examples above) I just dont see how that can
be done correctly in keeping all the prementioned virtual devices part
of the network device's directory in the tree. 

> 
> That's why I think a "non-physical" tree (not under $DRIVERFS/root) is more
> sensible in such cases.  Which is not to say it's without additional issues
> (like how to establish/maintain driver linkages that are DAGs not single
> parent trees) but it wouldn't require drivers to dig as deeply into lower
> levels of their stack.  (And some network interfaces might well live in
> such a non-physical tree, not just iSCSI...)
> 

I am in complete agreement, from my little view of where driverfs
currently stands a non-physical tree is going to have to happen sooner
or later,  why not now?  

> I think that problem wouldn't quite be isomorphic to multipath access to
> devices, though it seems to be related.  "Driver stacking" is an area
> that "driverfs" doesn't seem to address quite yet ... not needed in the
> simpler driver scenarios, so that's what I'd expect at this stage.
> 
> - Dave
> 
Thanks!
			Nicholas Bellinger

