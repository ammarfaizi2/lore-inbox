Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbTFLXB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265046AbTFLXB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:01:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51453 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265045AbTFLXAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:00:34 -0400
Subject: Re: [PATCH] udev enhancements to use kernel event queue
From: Robert Love <rml@tech9.net>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030612230910.GA1896@kroah.com>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com>
	 <20030612150335.6710a94f.akpm@digeo.com> <20030612225040.GA1492@kroah.com>
	 <20030612155148.60a39787.akpm@digeo.com> <20030612230246.GA1782@kroah.com>
	 <20030612230910.GA1896@kroah.com>
Content-Type: text/plain
Message-Id: <1055459762.662.336.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 12 Jun 2003 16:16:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 16:09, Greg KH wrote:

> +
> +	envp [i++] = scratch;
> +	scratch += sprintf(scratch, "SEQNUM=%ld", sequence_num) + 1;
> +	++sequence_num;

Since I do not see a lock in here, I think you need to use atomics?

As is, you can also race and have the same sequence_num value written
out twice.

	Robert Love

