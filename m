Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVH3OWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVH3OWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVH3OWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:22:15 -0400
Received: from web51802.mail.yahoo.com ([206.190.38.233]:18037 "HELO
	web51802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932148AbVH3OWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:22:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cO0uYOPW24A1KrVpt4tpqGF5pQTmdBWLczxBEu3i3d2Uc69sS3nGjwf/arPJvLQVeFLCywmWrrfNLf3gY6VMrm+/asV32tqW58gFloe6NitPqRrWYD7ViTI95kNVW1OvHRHacmdzWBeAjnmz97KA71pZc+6jDdpOjKaldJpA8fc=  ;
Message-ID: <20050830142214.72958.qmail@web51802.mail.yahoo.com>
Date: Tue, 30 Aug 2005 07:22:13 -0700 (PDT)
From: Adeshara Tushar <adesharatushar@yahoo.com>
Subject: usage count in device driver and concurrency
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am wondering how to handle device usage count in
open and release call of device driver if hardware
need to be initialized on first open and shutdown on
last close. I have seen som code like

int open()
{
        /*some code*/
        device->usage++;
        if(device->usage==1)
                init_hardware();
        /*rest of code*/
}
void release ()
{
        /*some code*/
        if(device->usage==1)
                shutdown_hardware();
        device->usage--;
        /*rest of code*/
}
                                                      
                                                      
               
However, it seems to me that this code can make
problem.
If device->usage=0, and two process A,B execute line
        device->usage++;
concurretly, device->usage will become 2 when they 
come to next line. This will result in hardware being
used without initialization. Same things can happen in
release call also, which will result in no shutdown of
hardware.
               I have seen this type of code in
        /linux-2.6.8/drivers/ide/ide-disk.c and
        /linux-2.6.8/drivers/ide/ide-floppy.c

    Please let me know if its bug or not before I
start working on patches.


Regards,
Tushar

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
