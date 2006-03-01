Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWCATpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWCATpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWCATpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:45:35 -0500
Received: from soundwarez.org ([217.160.171.123]:65504 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932179AbWCATpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:45:34 -0500
Date: Wed, 1 Mar 2006 20:45:32 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: ambx1@neo.rr.com, akpm@osdl.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060301194532.GB25907@vrfy.org>
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 10:40:19PM +0100, Pierre Ossman wrote:
> User space hardware detection need the 'modalias' attributes in the
> sysfs tree. This patch adds support to the PNP bus.

> +
> +	/* FIXME: modalias can only do one alias */
> +	return sprintf(buf, "pnp:c%s\n", pos->id);

Without the FIXME actually "fixed", this does not make sense. You want to
match always on _all_ aliases. In most cases where you have more than
one, the first one is the vendor specific one which isn't interesting at
all on Linux. If you have more than one entry usually the second one is the
one you are looking for.

So eighter we find a way to encode _all_ id's in one modalias string which can
be matched by a wildcard or keep the current solution which iterates over the
sysfs "id" file and calls modprobe for every entry.

Thanks,
Kay
