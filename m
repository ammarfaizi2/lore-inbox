Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268416AbRGXSGW>; Tue, 24 Jul 2001 14:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268414AbRGXSGM>; Tue, 24 Jul 2001 14:06:12 -0400
Received: from [64.7.140.42] ([64.7.140.42]:18402 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S268411AbRGXSFy>;
	Tue, 24 Jul 2001 14:05:54 -0400
Message-ID: <018501c1146b$d24862e0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0107241447440.20326-100000@duckman.distro.conectiva>
Subject: Re: [RFC] Optimization for use-once pages
Date: Tue, 24 Jul 2001 14:09:45 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

From: "Rik van Riel" <riel@conectiva.com.br>
> Actually, the length of this interval could be even smaller
> and is often a point of furious debating.

Which is why I was avoiding flames earlier; I sorta
figured this might be a hot issue.

> Let me give you an example:
>
> - sequential access of a file
> - script reads the file in 80-byte segments
>   (parsing some arcane data structure)
> - these segments are accessed in rapid succession
> - each 80-byte segment is accessed ONCE
>
> In this case, even though the data is accessed only
> once, each page is touched PAGE_SIZE/80 times, with
> one 80-byte read() each time.

I'd figured that sort of scenario was the basis for counting
them all as one. What about

- random access of same file
- script reads one arcane 80 byte struct
- script updates that struct say PAGE_SIZE/80
times, with one 80-byte write() each time

If they're all counted as one, would the page age
correctly, if the script happens to take a few seconds
break between another flurry of all-as-one updating?

..Stu


