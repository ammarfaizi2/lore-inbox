Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSGNAbe>; Sat, 13 Jul 2002 20:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSGNAbd>; Sat, 13 Jul 2002 20:31:33 -0400
Received: from codepoet.org ([166.70.99.138]:50657 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315480AbSGNAbd>;
	Sat, 13 Jul 2002 20:31:33 -0400
Date: Sat, 13 Jul 2002 18:34:25 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714003425.GC29007@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
References: <200207121955.g6CJtQur018433@burner.fokus.gmd.de> <20020713054058.GA19292@codepoet.org> <20020713125346.B10051@zalem.puupuu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020713125346.B10051@zalem.puupuu.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Jul 13, 2002 at 12:53:46PM -0400, Olivier Galibert wrote:
> On Fri, Jul 12, 2002 at 11:40:58PM -0600, Erik Andersen wrote:
> > If you would throw away crdrecord's desire to do its own private
> > SCSI bus scanning
> 
> CDROM_SEND_PACKET sounds nice, but do you have a way to:
> 1- Find all cdrom-ish devices in the system
> 2- Find if a given device is cdrom-ish
> 
> By cdrom-ish, I mean cdrom, dvdrom, cd writer, dvd writer or a
> combination.
> 
> Point 1 is necessary to be a minimum user-friendly, point 2 is
> necessary because you can't trust users :-)

Well, one way would be to scan for them directly, i.e.:
    for i in /dev/hd* ; do 
	ioctl(fd, HDIO_GET_IDENTITY, &ident);
	if (!(ident.config & 0x4000) && ((ident.config & 0x1f00) >> 8)==5) {
	    /* Got an ATAPI cdrom drive */
	}
    for i in /dev/scd* ; do
	open ($i, O_RDONLY|O_NONBLOCK)) < 0) {
	    /* Got a SCSI cdrom drive */
	}
  
Of course making user space do this is pretty lame.  But we
have a much better way.  Each cdrom device registers with the
uniform cdrom driver, which can easily assign each registered
cdrom device a major and minor.  That scanning for cdroms would
be as simple as
    for i in /dev/cdrom* ; do
	open ($i, O_RDONLY|O_NONBLOCK)) < 0) {
	    /* Found a cdrom drive */
	}
    
 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
