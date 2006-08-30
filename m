Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWH3BLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWH3BLq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 21:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWH3BLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 21:11:46 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:49113 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932226AbWH3BLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 21:11:45 -0400
Date: Wed, 30 Aug 2006 03:11:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
In-Reply-To: <44F44639.90103@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0608291653500.6761@scrub.home>
References: <20060829115138.GA32714@infradead.org> <20060825142753.GK10659@infradead.org>
 <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
 <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
 <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com>
 <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 29 Aug 2006, Stefan Richter wrote:

> If "select" cannot be fixed or is not en vogue for any other reason, the
> configuration tools need to be improved otherwise, so that users are guided to
> options like USB_STORAGE and IEEE1394_SBP2 when SCSI or other "foreign"
> options were disabled.
> 
> The kernel configuration is currently presented as a tree, although the
> dependencies of config options are not a tree. That's were "select" helps.

Actually dependencies are a tree and kconfig verifies that it's valid as 
well and that's there "select" can wreak havoc.
select really creates a reverse dependency, i.e. the value of SCSI depends 
now on the USB_STORAGE value. This means now that all dependencies of the 
selected symbol have to be selected as well (either by the selecting 
symbol or by the selected symbol). With more complex dependencies this can 
quickly get out of hand in order to maintain a valid and correct 
dependency tree. That's why I'm not really happy about the current massive 
use of select and I'd rather find solutions with normal dependencies, 
which unfortunately isn't trivial, select OTOH was a simple hack.

bye, Roman
