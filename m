Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274612AbRIYOpc>; Tue, 25 Sep 2001 10:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275021AbRIYOpW>; Tue, 25 Sep 2001 10:45:22 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:18060 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S274612AbRIYOpL>;
	Tue, 25 Sep 2001 10:45:11 -0400
Date: Tue, 25 Sep 2001 15:47:21 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be
 better
Message-ID: <107194016.1001432841@[10.132.113.67]>
In-Reply-To: <20010925021113.B22073@emma1.emma.line.org>
In-Reply-To: <20010925021113.B22073@emma1.emma.line.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, September 25, 2001 2:11 AM +0200 Matthias Andree 
<matthias.andree@stud.uni-dortmund.de> wrote:

> Why are disk drives slower with their caches disabled on LINEAR writes?

Probably because sectors are so close together on the physical media.
If you disable write caching, and are writing sectors 1001, 1002, 1003
etc., you tell it to write sector 1001, and it doesn't complete until
it's written it, you IRQ the PC, and it sends the write out for 1002,
which completes a little later. However, by this time 1002 has
flown past the drive head, as it wasn't immediately queued on the drive.
If you had only one sector of writeahead, this effect would disappear
(but is just as theoretically dangerous if there is no way to force
a flush() of the write cache).

--
Alex Bligh
