Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSGEEsg>; Fri, 5 Jul 2002 00:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSGEEsf>; Fri, 5 Jul 2002 00:48:35 -0400
Received: from ns0.tateyama.or.jp ([210.128.170.1]:3844 "HELO
	ns0.tateyama.or.jp") by vger.kernel.org with SMTP
	id <S315293AbSGEEsf> convert rfc822-to-8bit; Fri, 5 Jul 2002 00:48:35 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Gabor Kerenyi <wom@tateyama.hu>
To: linux-kernel@vger.kernel.org
Subject: PCI bus access method
Date: Fri, 5 Jul 2002 13:56:43 +0900
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207051356.43204.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm curious about which one of the following code
segments is executed faster. They are in an interrupt
handler, the readings and writings are done on the PCI bus.

__u32 tmp;
int i;
for (i=0;i<128;i++) {
	tmp=readb(dev->dpmem+i);
	if (!tmp) continue;
	writeb(0,dev->dpmem+i);
	some_code;
}

256 PCI bus access in the worst case, but fewer code

or

__u32 tmp;
int i,j;
char *p=&tmp;
for (i=0;i<128;i+=4) {
	tmp=readl(dev->dpmem+i);
	if (!tmp) continue;
	writel(0, dev->dpmem+i);
	for (j=0;j<4;j++)
		if (*(p+j)) {
			some_code;
		}
}

64 PCI bus access in the worst case but more code

Thanks,

Gabor

