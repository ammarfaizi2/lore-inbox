Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTCDVoH>; Tue, 4 Mar 2003 16:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTCDVoH>; Tue, 4 Mar 2003 16:44:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28321
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261486AbTCDVoF>; Tue, 4 Mar 2003 16:44:05 -0500
Subject: Re: IDE DVD reading & error handling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mathias.kretschmer@verizon.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E64EE6A.90208@lemur.sytes.net>
References: <3E64EE6A.90208@lemur.sytes.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046818748.12226.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 04 Mar 2003 22:59:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 18:20, Mathias Kretschmer wrote:
> Is there a way to optimize the IDE layer to handle DVD
> read errors more gracefully ?

I think its perfectly doable to set the maximum retries per
device. Have a look at the current ide_error() and the error: handler
in the relevant ide drivers (notably ide-cd).

> I wonder if it would be possible to tune the IDE layer by i.e.
> reducing the number of retries and disabling the controller reset, etc.

A lot of the time you have to go through the controller reset. However 
cutting the retries down and having good readahead management on the
I/O thread ought to still cope with that.

As to drives I'm using a mix of drives. Old 1x and 2x speed DVD drives
are very cheap so its a good way to get multiple regions cheaply, and
saves breaking the DMCA in the US 8)

