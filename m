Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287873AbSABS1r>; Wed, 2 Jan 2002 13:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287876AbSABS1g>; Wed, 2 Jan 2002 13:27:36 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:39160 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S287873AbSABS12>;
	Wed, 2 Jan 2002 13:27:28 -0500
Message-ID: <3C3350C7.D11110A@gmx.de>
Date: Wed, 02 Jan 2002 19:26:15 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Michal Moskal <malekith@pld.org.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: strange TCP stack behiviour with write()es in pieces
In-Reply-To: <20020102162806.GA29399@ep09.kernel.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Moskal wrote:
> 
> So, it occurs in programs doing packet communication over TCP, when
> peer waits for a packet to send an answer. If they send data with two
> write() calls (for example to write packet header and packet data),
> the performance dramaticly decrases (down to exactly 100 (2.2.19)
> or 25 (2.4.[57]) packet exchanges per second on x86, from several
> thousands. 100 seems to be related to HZ variable, see also AXP results,
> where HZ is 10 times bigger).

Try disabling the nagle algorithm:

        int i = 1;
        if (setsockopt(fd, SOL_TCP, TCP_NODELAY, &i, sizeof(i)) == -1)
            perror("TCP_NODELAY");

Ciao, ET.
