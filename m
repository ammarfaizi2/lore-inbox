Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVDFDHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVDFDHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 23:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVDFDHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 23:07:23 -0400
Received: from mail43-s.fg.online.no ([148.122.161.43]:63121 "EHLO
	mail43-s.fg.online.no") by vger.kernel.org with ESMTP
	id S262087AbVDFDHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 23:07:18 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <lists@kenneth.aafloy.net>
To: arun.prabha@wipro.com
Subject: Re: Scheduling tasklets from process context...
Date: Wed, 6 Apr 2005 05:07:15 +0200
User-Agent: KMail/1.8
References: <8F94FD7C111E3D43BA3C7CF89CB50E92012AA7B5@BLR-EC-2K3MSG.wipro.com>
In-Reply-To: <8F94FD7C111E3D43BA3C7CF89CB50E92012AA7B5@BLR-EC-2K3MSG.wipro.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504060507.15560.lists@kenneth.aafloy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 04:50, you wrote:
> Since tasklets are typically used for bottom half processing, is it
> acceptable/recommended that they be scheduled from a process context
> (say an ioctl handler)? 
> 
> Should one try to minimize such scheduling and try to do things in process
> context if possible, as tasklets run in interrupt context? Or is the driver
> writer free to use the tasklets at will? What is recommended here?

A tasklet does not run in interrupt context, it runs as a high priority thread,
that is scheduled from either user or interrupt context. The purpose is mostly
to defer workloads from interrupt context, to reduce the time spent with
interrupts disabled.

It would make sense to defer work from userspace to a tasklet if the hardware
takes an unusual amount of time to process the userspace data.

Correct me if I'm wrong :)

Kenneth
