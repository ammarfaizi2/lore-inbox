Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSH0NXf>; Tue, 27 Aug 2002 09:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316113AbSH0NXf>; Tue, 27 Aug 2002 09:23:35 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:26116 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316088AbSH0NXe>; Tue, 27 Aug 2002 09:23:34 -0400
Date: Tue, 27 Aug 2002 14:27:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: aia21@cantab.net, kernel@bonin.ca, linux-kernel@vger.kernel.org
Subject: Re: Loop devices under NTFS
Message-ID: <20020827142750.A26266@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>, aia21@cantab.net,
	kernel@bonin.ca, linux-kernel@vger.kernel.org
References: <200208271323.GAA04833@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208271323.GAA04833@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Aug 27, 2002 at 06:23:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 06:23:48AM -0700, Adam J. Richter wrote:
> 	Are you complaining about something in loop.c,

Yes.  Anything but the filesystem itself and the generic read/write path
is not supposed to use address space operations directly.

> >Note that there is a more severe bug in loop.c:  it's abuse of
> >do_generic_file_read.  
> 
> 	Could you please elaborate on this and give an example where
> it return incorrect data, deadlock, generate a kernel oops, etc.?

Depending on the filesystem implementation _anything_ may happen.
With current intree filesystems the only real life problem is that
it doesn't work on certain filesystems.  I think at least the network
filesystems might be oopsable with some preparation.

