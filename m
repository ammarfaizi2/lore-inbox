Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVEDS35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVEDS35 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVEDS33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:29:29 -0400
Received: from p4.gsnoc.net ([209.51.147.210]:27859 "EHLO p4.gsnoc.net")
	by vger.kernel.org with ESMTP id S261363AbVEDS0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:26:48 -0400
Message-ID: <427913E4.3070908@cachola.com.br>
Date: Wed, 04 May 2005 15:26:44 -0300
From: =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= <andre@cachola.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: A patch for the file kernel/fork.c
References: <4278E03A.1000605@cachola.com.br> <20050504175457.GA31789@taniwha.stupidest.org>
In-Reply-To: <20050504175457.GA31789@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p4.gsnoc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - cachola.com.br
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Wed, May 04, 2005 at 11:46:18AM -0300, Andr? Pereira de Almeida wrote:
>
>  
>
>>-       if (tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {
>>+       if (mm && tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {
>>    
>>
>
>did you actually see a problem here?
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
In a preemptible kernel with the serport module and a serial port try to 
run the following program:

int main(int argc, char **argv)
{
        int ldisc,fd;

        fd = open("/dev/ttyS0", O_RDWR | O_NOCTTY | O_NONBLOCK);
        ldisc = N_MOUSE;
        ioctl(fd, TIOCSETD, &ldisc);
        read(fd, NULL, 0);
        return 0;
}

and kill it.
In my case it will hang the computer. I think this is a problem with the 
serport module. With this patch, the serial mouse stop working, but the 
computer don't hang.

