Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVB0LFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVB0LFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 06:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVB0LFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 06:05:25 -0500
Received: from [211.87.226.12] ([211.87.226.12]:13038 "HELO qlsc.sdu.edu.cn")
	by vger.kernel.org with SMTP id S261375AbVB0LFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 06:05:20 -0500
IP: 211.87.234.238
Message-ID: <422219ED.5060404@qlsc.sdu.edu.cn>
Date: Sun, 27 Feb 2005 19:05:17 +0000
From: Neil <neil@qlsc.sdu.edu.cn>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Yet another I/O modeling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,all
select/poll I/O modeling is fast,easy to use,it returns the number of fd 
which are acitvity,but you should scan the fd array to find which fd is 
ready,it costs a lot of time on a heavy load server.

I proposal another I/O modeling,named eselect.
struct eselect_struct{
    unsigned long readbitmap[MAXBITMAPFD];//suppose the MAXBITMAPFD is 
MAX OPEN                                         //FD NUMBER PER PROCESS
    int ret;//-1 on error,non-negative return value is the number of     
            //acitvity fds
}
we can use __set_bit(),__clear_bit(),__find_first_bit()....functions to 
maintain the bitmap.
So,you shouldnt scan the fd array any more.



