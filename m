Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbTD1TUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 15:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbTD1TUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 15:20:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52151 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261255AbTD1TUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 15:20:12 -0400
Date: Mon, 28 Apr 2003 20:32:28 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reducing overheads in fget/fput
Message-ID: <20030428193228.GP10374@parcelfarce.linux.theplanet.co.uk>
References: <20030428165240.GA1105@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428165240.GA1105@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 10:22:40PM +0530, Dipankar Sarma wrote:
> Does this approach make sense ? Or am I missing some big gotcha
> somewhere ? Oh, btw the patch survives LTP.

You are.  Have a process share file table at the time of call and
have its sibling die in the middle.  Oops - condition that had
been true at time of fget_light() (->files->count > 1) is false
at the time we fput_light().  Have fun - we had just leaked a
reference to struct file.
