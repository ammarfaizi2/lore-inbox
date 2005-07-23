Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVGWMbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVGWMbh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 08:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVGWMbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 08:31:37 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12450 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261544AbVGWMbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 08:31:35 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "John Pearson" <john@illhostit.com>,
       "Erik Mouw" <erik@harddisk-recovery.com>, "Ashley" <ashleyz@alchip.com>
Subject: Re: Kernel cached memory
Date: Sat, 23 Jul 2005 15:31:20 +0300
User-Agent: KMail/1.5.4
Cc: <linux-kernel@vger.kernel.org>
References: <JCEEICIEKCENOEGFMGBACEAGCAAA.john@illhostit.com>
In-Reply-To: <JCEEICIEKCENOEGFMGBACEAGCAAA.john@illhostit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507231531.20377.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 July 2005 00:43, John Pearson wrote:
> Wouldn't having (practically) all your memory used for cache slow down
> starting a new program? First it would have to free up that space, and then
> put stuff in that space, taking potentially twice as long. I think there
> should be a system call for freeing cached memory, for those that do want to
> do it.

I think this one is good enough:

#include <stdlib.h>

int main() {
    void *p;
    unsigned size = 1<<20;
    unsigned long total=0;
    while(size) {
        p = malloc(size);
        if(!p) size>>=1;
        else {
            memset(p, 0x77, size);
            total+=size;
            printf("Allocated %9u bytes, %12lu total\n",size,total);
        }
    }
    return 0;
}

You may want to adapt it so that it takes an argument now many megabytes
to eat before it dies.
--
vda

