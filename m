Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbTD1Tnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 15:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbTD1Tnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 15:43:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:962 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261259AbTD1Tni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 15:43:38 -0400
Date: Tue, 29 Apr 2003 01:28:36 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reducing overheads in fget/fput
Message-ID: <20030428195836.GD1105@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030428165240.GA1105@in.ibm.com> <20030428193228.GP10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428193228.GP10374@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 08:32:28PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> You are.  Have a process share file table at the time of call and
> have its sibling die in the middle.  Oops - condition that had
> been true at time of fget_light() (->files->count > 1) is false
> at the time we fput_light().  Have fun - we had just leaked a
> reference to struct file.

That shouldn't be very difficult to fix. For the fget_light/fput_light
pair in a syscall, we make the files->count == 1 check only once at the 
beginning. Do you see a problem with that ?

Thanks
Dipankar
