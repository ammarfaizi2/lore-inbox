Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbUBKOP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUBKOP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:15:27 -0500
Received: from kamikaze.scarlet-internet.nl ([213.204.195.165]:36799 "EHLO
	kamikaze.scarlet-internet.nl") by vger.kernel.org with ESMTP
	id S264383AbUBKOPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:15:23 -0500
Message-ID: <1076508920.402a38f8ee106@webmail.dds.nl>
Date: Wed, 11 Feb 2004 15:15:20 +0100
From: wdebruij@dds.nl
To: =?iso-8859-1?b?TeVucyA=?= =?iso-8859-1?b?UnVsbGflcmQ=?= 
	<mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: printk and long long
References: <Sea2-F7mFkwDjKqc3eQ0001c385@hotmail.com> <1076506513.402a2f9120fb8@webmail.dds.nl> <yw1xy8r9iuha.fsf@kth.se>
In-Reply-To: <yw1xy8r9iuha.fsf@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Måns Rullgård <mru@kth.se>:

> 
> And how do you plan to make sense of the printed value?
> 

perhaps I was a bit quick with replying. As others have pointed out, you should
specify the precision to be able to glue the two parts together. Ideally, this
should be done using a "%.8lx%.8lx", since the length of the variable in hex is
static. Unfortunately, it seems %ld is requested, in which case "%ld*(2^32)+%ld"
works (for humans), but is obviously not great.

I guess you'll need a number of extra tests (if lower 32bits > 1 billion ..) and
specific printk statements if the output should be shown as a correct 10-base
number. 

I don't know, it depends on the specific use-case, really. If at all possible, I
would stick to the hex-representation.
