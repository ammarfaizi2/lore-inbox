Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUHKVjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUHKVjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268241AbUHKVhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:37:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40390 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268245AbUHKVg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:36:58 -0400
Date: Wed, 11 Aug 2004 18:14:30 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Jirka Kosina <jikos@jikos.cz>, Giuliano Pochini <pochini@shiny.it>,
       linux-kernel@vger.kernel.org
Subject: Re: FW: Linux kernel file offset pointer races
Message-ID: <20040811211430.GA4275@dmt.cyclades>
References: <XFMail.20040805104213.pochini@shiny.it> <Pine.LNX.4.58.0408051228400.2791@twin.jikos.cz> <20040807171500.GA26084@logos.cnet> <20040811182602.A2055@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811182602.A2055@castle.nmd.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 06:26:02PM +0400, Andrey Savochkin wrote:
> BTW, f_pos assignments are non-atomic on IA-32 since it's a 64-bit value.
> The file position is protected by the BKL in llseek(), but I do not see any
> serialization neither in sys_read() nor in generic_file_read() and other
> methods.
> 
> Have we accepted that the file position may be corrupted after crossing 2^32
> boundary by 2 processes reading in parallel from the same file?
> Or am I missing something?

Yes, as far as I know, parallel users of the same file descriptions (which 
can race on 64-bit architectures) is expected, we dont care about handling it.

Behaviour is undefined. 


