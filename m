Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbTK3LYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 06:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTK3LYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 06:24:21 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:9447 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264886AbTK3LYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 06:24:20 -0500
Date: Sun, 30 Nov 2003 12:24:19 +0100
To: John Bradford <john@grabjohn.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Clausen <clausen@gnu.org>,
       Apurva Mehta <apurva@gmx.net>, Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031130112419.GA2920@iliana>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk> <20031129223103.GB505@gnu.org> <1070182676.5214.2.camel@laptop.fenrus.com> <200311301040.hAUAePk6000149@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200311301040.hAUAePk6000149@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 10:40:25AM +0000, John Bradford wrote:
> * All partition information stored in one partition table
> 
> Linked lists make re-arranging partitions, and backing up the
> partition table more difficult.

I don't agree here. You just follow the linked list and make the backup,
which is one more reason for having the save/restore mechanism in the
per partition table code, which knows how to read/write the partition
table anyway. Also, mostly the linked list is found in a chunk of the
disk which you can easily backup with dd. The amiga scheme has both
information about the number of sectors which can be used in the linked
list, as well as the last used sector.

Also, with a linked list, you can maintain two or more partition tables
on disk, thus making an on-disk backup easy. When you write a new
partition table, you write it on other sectors than the first one, and
then update the root pointer. You can then later go back to the old
partition table by just restoring the root pointer or something such.

Also, it allow you flexibility with the amount of partitions you can
use, as you could have potentially have any number of partitions you
like (upto 2^30 or such).

Friendly,

Sven Luther
