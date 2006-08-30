Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWH3Ldg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWH3Ldg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 07:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWH3Ldg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 07:33:36 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:17553 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1750855AbWH3Ldf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 07:33:35 -0400
Message-ID: <44F5769B.7060902@s5r6.in-berlin.de>
Date: Wed, 30 Aug 2006 13:29:31 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
References: <20060829115138.GA32714@infradead.org> <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de> <Pine.LNX.4.64.0608291653500.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0608291653500.6761@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Tue, 29 Aug 2006, Stefan Richter wrote:
[...]
>> The kernel configuration is currently presented as a tree, although the
>> dependencies of config options are not a tree. That's were "select" helps.
> 
> Actually dependencies are a tree and kconfig verifies that it's valid as 
> well and that's there "select" can wreak havoc.

OK. You are right, they are both trees. But the menu tree is different
from the dependency tree. I can see two reasons: 1. We expect the menu's
layout to reflect function rather than implementation. 2. Menu tree and
dependency tree are directed trees, but only the menu tree has a root
(i.e. _one_ root).

> select really creates a reverse dependency, i.e. the value of SCSI depends 
> now on the USB_STORAGE value.

It doesn't really revert the dependency. It changes the path that the
user takes to enable interdependent options. Thereby it changes _how_
the configurator ensures (or rather, _should_ ensure) that dependencies
are fulfilled.

> This means now that all dependencies of the 
> selected symbol have to be selected as well (either by the selecting 
> symbol or by the selected symbol). With more complex dependencies this can
> quickly get out of hand in order to maintain a valid and correct 
> dependency tree. That's why I'm not really happy about the current massive 
> use of select and I'd rather find solutions with normal dependencies, 
> which unfortunately isn't trivial, select OTOH was a simple hack.

"select" would not be needed if the configurator wouldn't make an option
_invisible_ if it depends on another disabled option. It would be nice
if the option would stay visible (or better yet, would be optionally
visible) and had pointers to unfulfilled dependencies.

Or more generally spoken, "select" would not be needed if there were
other means to switch the configurator's UI to a layout that exposes
more details about dependencies. There is already such a UI mode which
fully exposes _fulfilled_ dependencies.
-- 
Stefan Richter
-=====-=-==- =--- ====-
http://arcgraph.de/sr/
