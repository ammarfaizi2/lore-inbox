Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbUBYJOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 04:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUBYJO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 04:14:29 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:10131 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S262505AbUBYJO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 04:14:28 -0500
Date: Wed, 25 Feb 2004 11:14:25 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
Message-ID: <20040225091425.GA16783@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <403C014F.2040504@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403C014F.2040504@blue-labs.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 08:58:39PM -0500, David Ford wrote:
> Kernel 2.6.3, procps 3.2.0
> 
> Note the change in the timestamp as reported by 'ps' v.s. the time 
> reported by 'date'.
> 

Hi,

I reported the same problem some time ago. Could you type

grep cpu /proc/stat; cat /proc/uptime

for example, I get

cpu  140708 1489 43735 21209021 292168 4879 4192
cpu0 140708 1489 43735 21209021 292168 4879 4192
216925.15 215037.34

Then add jiffies and divide by uptime:

(140708+1489+43735+21209021+292168+4879+4192)/216925.15 = 100.01695

which is not 100 here as it should be. (On kernel 2.2.* I have it exactly
100). ps uses Hertz=100 but it should be 170 ppm larger which makes an error
of about 15 seconds a day. (Running without ntpd doesn't fix it.)
