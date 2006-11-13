Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755327AbWKMS4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbWKMS4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755331AbWKMS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:56:29 -0500
Received: from s1.mailresponder.info ([193.24.237.10]:13331 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S1755326AbWKMS42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:56:28 -0500
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
From: Mathieu Fluhr <mfluhr@nero.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4558BE57.4020700@cfl.rr.com>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
	 <4558BE57.4020700@cfl.rr.com>
Content-Type: text/plain
Organization: Nero AG
Date: Mon, 13 Nov 2006 19:56:00 +0100
Message-Id: <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 13:49 -0500, Phillip Susi wrote:
> Mathieu Fluhr wrote:
> > Hello,
> > 
> > I recently tried to burn some datas on CDs and DVD using a SATA burner
> > and the latest 2.6.18.2 kernel... using NeroLINUX. (It is controlling
> > the device by sending SCSI commands over the 'sg' driver)
> > 
> 
> Please note that the sg interface is depreciated.  It is now recommended 
> that you send the CCBs directly to the normal device, i.e. /dev/hdc.

Of course for native IDE devices, we are using the /dev/hdXX device, but
for SATA devices controlled by the libata, this is not possible ;)

> 
> > The burn process works like a charm, no problems at all. But it seems
> > that there are some slight problems with the READ scsi cmd:
> > Inside our software, we have a verification routine that will make a
> > sector-by-sector verification to check that everything that has been
> > written is OK.
> > 
> > The problem is that, on SATA devices controlled by libata, on some big
> > files (like for example a 600 MB file) the READ command seems to fail
> > and outputs garbage (not 1 or 2 bytes diff, but the whole buffer).
> >  -> This problem does not come out everytime, and each time on    
> >     different sectors.
> > 
> 
> I'm not sure what you mean by "on some big files" as the sg interface 
> has no notion of files; you're just reading the disk sector by sector, 
> as you said earlier.  Also by fail do you mean that the request returns 
> an error status?  If so then the read buffer will not be valid.

I said 'some big files', as the problem is not reproducable everytime.
It occurs most of the time with large files.
The request does not return an error code (no sense key I mean), and it
is working as if everything would have work fine.

> 
> 

