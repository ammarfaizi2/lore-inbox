Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262245AbSJAUTk>; Tue, 1 Oct 2002 16:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbSJAUTk>; Tue, 1 Oct 2002 16:19:40 -0400
Received: from packet.digeo.com ([12.110.80.53]:64999 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262245AbSJAUTk>;
	Tue, 1 Oct 2002 16:19:40 -0400
Message-ID: <3D9A04B4.B1355CB6@digeo.com>
Date: Tue, 01 Oct 2002 13:25:24 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lawrence Walton <lawrence@the-penguin.otak.com>,
       Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops iee1394 video1394 rmap
References: <20021001195313.GA28769@the-penguin.otak.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2002 20:25:01.0287 (UTC) FILETIME=[9E589770:01C26988]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Walton wrote:
> 
> I just got a oops playing with a firewire camera.
> I don't think a full report is nessesary, but please spank
> me if not. :) And I will get it out ASAP.
> 
> All the iee1394 stuff was built as modules.
> 
> ...
> kernel BUG at rmap.c:280!

This would appear to be a page which was mapped by remap_page_range().
It's not PageReserved, and it has no reverse mapping.

I believe the right fix is to just delete the BUG check at rmap.c:280.
Could you please try that?  An appropriate test would be to play with
the camera while running something which causes tons of swapout.

Rik, that's right, isn't it?
