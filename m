Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282880AbRLGQix>; Fri, 7 Dec 2001 11:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282878AbRLGQio>; Fri, 7 Dec 2001 11:38:44 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:37771 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282880AbRLGQif>; Fri, 7 Dec 2001 11:38:35 -0500
Date: Fri, 7 Dec 2001 09:38:09 -0700
Message-Id: <200112071638.fB7Gc9X14718@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] /
In-Reply-To: <1007740060.2031.2.camel@thanatos>
In-Reply-To: <1007740060.2031.2.camel@thanatos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood writes:
> Some devfs permission problems may have arisen because of the
> fact that devfs now notifies devfsd of the creation of
> directories.  Many people have devfsd configured to set
> permissions to all devices matching a certain regular
> expression --- e.g., all devices with "sound" in their
> pathname.  The problem is that the "sound" directory itself
> matches this regular expression, and so will have its perm
> bits set exactly like the device files' perm bits---e.g.,
> with the eXamine bit cleared.  The solution is to edit the
> devfsd config so that it excludes the directory.  E.g.,
> instead of:
>     REGISTER sound PERMISSIONS root.audio 0664
> (which worked before but won't any more) do:
>     REGISTER ^sound/.* PERMISSIONS root.audio 0664
> or something similar.

Hey! Good spotting! Since the person with the problem didn't send in
his devfsd configuration file, I'm guessing you ran across this
problem yourself?

FYI: recent versions of devfsd now also generate synthetic REGISTER
events for directories. So even with older kernels, people need to fix
their config files.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
