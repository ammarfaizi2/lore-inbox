Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262428AbTCMSZ3>; Thu, 13 Mar 2003 13:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbTCMSZ3>; Thu, 13 Mar 2003 13:25:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24783
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262428AbTCMSZ2>; Thu, 13 Mar 2003 13:25:28 -0500
Subject: Re: dpt_i2o.c memleak/incorrectness
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       deanna_bonds@adaptec.com
In-Reply-To: <20030313182819.GA2213@linuxhacker.ru>
References: <20030313182819.GA2213@linuxhacker.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047584663.25948.75.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 13 Mar 2003 19:44:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 18:28, Oleg Drokin wrote:
> Hello!
> 
>    There is something strange going on in drivers/scsi/dpt_i2o.c in both
>    2.4 and 2.5. adpt_i2o_reset_hba() function allocates 4 bytes 
>    for "status" stuff, then tries to reset controller, then 
>    if timeout on first reset stage is reached, frees "status" and returns,
>    otherwise it proceeds to monitor "status" (which is modified by hardware
>    now, btw), and if timeout is reached, just exits.

Correctly - I2O does the same thing in this case. Its just better to
throw a few bytes away than risk corruption

