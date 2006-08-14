Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752074AbWHNXXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbWHNXXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbWHNXXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:23:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32775 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752074AbWHNXXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:23:38 -0400
Date: Tue, 15 Aug 2006 01:23:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Martin Samuelsson <sam@home.se>, mchehab@infradead.org
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: drivers/media/video/bt866.c: array overflows
Message-ID: <20060814232337.GZ3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following two array overflows:


<--  snip  -->

...
struct bt866 {
...
        unsigned char reg[128];
...
}
...
static int bt866_do_command(struct bt866 *encoder,
                        unsigned int cmd, void *arg)
{
...
                val = encoder->reg[0xdc];
...
                bt866_write(encoder, 0xdc, val);
...
}
...
static int bt866_write(struct bt866 *encoder,
                        unsigned char subaddr, unsigned char data)
{
...
        encoder->reg[subaddr] = data;
...
}
...

<--  snip  -->


The two bugs are obvious:
  0xdc = 220 >= 128


cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

