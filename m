Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSIJKTD>; Tue, 10 Sep 2002 06:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSIJKTC>; Tue, 10 Sep 2002 06:19:02 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:56890 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317373AbSIJKTC>;
	Tue, 10 Sep 2002 06:19:02 -0400
Date: Tue, 10 Sep 2002 12:23:46 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020910102346.GB12068@win.tue.nl>
References: <20020909221727.GF7433@kroah.com> <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com> <20020910001945.GB8477@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020910001945.GB8477@kroah.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 05:19:45PM -0700, Greg KH wrote:
> On Mon, Sep 09, 2002 at 05:17:40PM -0700, Linus Torvalds wrote:

> > Greg, please don't do this
> > 
> > Rule of thumb: BUG() is only good for something that never happens
> 
> Sorry, Matt told me to add it, I didn't realize the background.  Should
> I leave it as show_trace(), or just remove it?  Do you want me to send
> you another changeset to put it back?

There were a few BUG_ON calls in scsi_glue.c and in transport.c that
killed machines. For transport.c my source has

        if (len != srb->request_bufflen) {
                printk("USB transport.c: len=%d srb->request_bufflen=%d\n",
                       len, srb->request_bufflen);
#if 0
                show_trace(NULL);
#endif
        }
(show_trace was not defined here; I think the call should be deleted).

With some luck Alan's fix means that the ones in usb_stor_abort_transport()
and [us_]release() are not triggered anymore.

Andries
