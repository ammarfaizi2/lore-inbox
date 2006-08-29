Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965379AbWH2VJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965379AbWH2VJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965378AbWH2VJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:09:57 -0400
Received: from mxsf31.cluster1.charter.net ([209.225.28.130]:59331 "EHLO
	mxsf31.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965371AbWH2VJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:09:56 -0400
X-IronPort-AV: i="4.08,183,1154923200"; 
   d="scan'208"; a="1583680957:sNHT27777000"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17652.44254.620358.974993@stoffel.org>
Date: Tue, 29 Aug 2006 17:08:46 -0400
From: "John Stoffel" <john@stoffel.org>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
In-Reply-To: <20060829195845.GA13357@kroah.com>
References: <20060829115138.GA32714@infradead.org>
	<20060825142753.GK10659@infradead.org>
	<20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
	<20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
	<10117.1156522985@warthog.cambridge.redhat.com>
	<15945.1156854198@warthog.cambridge.redhat.com>
	<20060829122501.GA7814@infradead.org>
	<20060829195845.GA13357@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

Greg> On Tue, Aug 29, 2006 at 01:25:01PM +0100, Christoph Hellwig wrote:
>> On Tue, Aug 29, 2006 at 01:23:18PM +0100, David Howells wrote:
>> > Christoph Hellwig <hch@infradead.org> wrote:
>> > 
>> > > Same as above.  USB_STORAGE already selects scsi so it shouldn't need
>> > > to depend on block.
>> > 
>> > Ah, you've got it the wrong way round.
>> > 
>> > Because USB_STORAGE _selects_ SCSI rather than depending on it, even if SCSI
>> > is disabled, USB_STORAGE can be enabled, and that turns on CONFIG_SCSI, even
>> > if not all of its dependencies are available.
>> > 
>> > Run "make allyesconfig" and then try to turn off CONFIG_SCSI without this...
>> 
>> Eeek.  The easy fix is to change USB_STORAGE to depend on SCSI (*), but in
>> addition to that we should probably fix Kconfig aswell to adhere to
>> such constraints.

Greg> No, the reason this was switched around like this (it used to be the
Greg> other way), was that people constantly complained about not being able
Greg> to select the usb-storage driver in their configurations.

Maybe the better solution is to remove SCSI as an option, and to just
offer SCSI drivers and USB-STORAGE and other SCSI core using drivers
instead.  Then the SCSI core gets pulled in automatically.  It's not
like people care about the SCSI core, just the drivers which depend on
it.

John
