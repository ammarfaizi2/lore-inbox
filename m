Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWAPPDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWAPPDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWAPPDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:03:09 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:58779 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750857AbWAPPDI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:03:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rRBsqpPEe5tgSo8M58v0wmjSbVz23Jf55QoaQNET02c0tRF4HKfOHWRtQUPOGl9DPgb8hpYoniBPKzww2P3sQcygmuhpiG8lXD739jGHvJGBh73TiRAnZKGZ894k/WcZ+uWK5yPpgXKUis4uVlKIXprwDVvamURFhun2gbb5gzM=
Message-ID: <170fa0d20601160703p68e582ecq54ade82940b6d6cb@mail.gmail.com>
Date: Mon, 16 Jan 2006 10:03:06 -0500
From: Mike Snitzer <snitzer@gmail.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: unify sysfs device tree
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <20060116134314.GA10813@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060113015652.GA30796@vrfy.org> <20060116134314.GA10813@vrfy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, Kay Sievers <kay.sievers@vrfy.org> wrote:

> Here is an updated patch, that:
>   o moves the devices in /sys/block to /sys/devices to match the
>     class layout. Block devices will be childs of their physical
>     device chain like every other class device too. Partitions
>     will be childs of the disk device. A usual DEVPATH looks like:
>       /devices/pci0000:00/0000:00:1f.2/host0/target0:0:0/0:0:0:0/sda/sda1
>
>   o flattens the block class view and moves the block symlinks to
>     /sys/class/block. Disks and partitons like /sys/class/block/sda
>     and /sys/class/block/sda1 will be at the same level. /sys/block
>     does not longer exist.

What is the problem with maintaining compatibility by having
/sys/block be a symlink to /sys/class/block?  Userspace applications
shouldn't have to now conditionalize the path to block devices
(/sys/block/... vs /sys/class/block/...).  Forcing this kind of change
is what taints Linux for use in hardened applications. 
Conditionalizing code for 2.4 vs 2.6 is understandable but having to
do so for minor 2.6.x revisions is rediculous.  <insert ref to Linus'
views in the recent 'userspace breakage' thread here>.

Mike
