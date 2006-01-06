Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWAFPTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWAFPTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWAFPTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:19:00 -0500
Received: from web34102.mail.mud.yahoo.com ([66.163.178.100]:62578 "HELO
	web34102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932446AbWAFPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:18:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=w6F2KnlEghcENceeUW70/joHYtQgpTBfIM90Fx9rl39eYOMEysY4zDynv7KXwaocQxT0b+BmANnFfS3/KZKPrLNBCnQ59hh9BXVMSeeVM5hOT00VWSAJWX6acFW+K8LcWVzwLQYDsj13sue2PAEZ31q24RwfDG27CC1AulEnaZ0=  ;
Message-ID: <20060106151855.63846.qmail@web34102.mail.mud.yahoo.com>
Date: Fri, 6 Jan 2006 07:18:55 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: RE: RAID controller safety
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1136558807.30498.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2006-01-06 at 09:33 -0500, Salyzyn, Mark wrote:
> > The dpt_i2o driver (which is a scsi driver) accepts the
> > SYNCHRONIZE_CACHE scsi command and passes it off to the firmware. The
> > firmware respects this and flushes all the outstanding (cached)
> > commands. This is true in all (kernel.org or Adaptec latest) versions.
> 
> In which case it should be fine and correct with the generic i2o_scsi as
> well as that will pass through SCSI command requests directly. i2o_block
> doesn't know about converting any incoming cache flush to an i2o command
> block so might not.
> 
> Alan
> 

Won't the i2o_block driver use i2o_block_device_flush to flush the devices' cache (by issuing a
I2O_CMD_BLOCK_CFLUSH), or this this function used in some very different context?

Oddly enough, I see I2O_CMD_BLOCK_CFLISH #define'd to 0x37 in both the i2o driver
(include/linux/i2o.h), AND in the dpt driver (drivers/scsi/dpt/dpti_i2o.h).  However, I do not see
the dpt driver using this value anywhere.

-Kenny



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

