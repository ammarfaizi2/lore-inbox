Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315835AbSEQMec>; Fri, 17 May 2002 08:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSEQMdM>; Fri, 17 May 2002 08:33:12 -0400
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:61099 "EHLO
	albatross.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S315835AbSEQMch>; Fri, 17 May 2002 08:32:37 -0400
Message-ID: <3CE4F864.6E9B93AD@uab.ericsson.se>
Date: Fri, 17 May 2002 14:32:36 +0200
From: Sverker Wiberg <Sverker.Wiberg@uab.ericsson.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: knfsd misses occasional writes (w/ WORKAROUND)
In-Reply-To: <3CE250A5.47F71DF@uab.ericsson.se> <15586.20989.992591.474108@notabene.cse.unsw.edu.au> <3CE38E9D.986ACF7F@uab.ericsson.se> <20020516143441.A4322@laclinux.com> <3CE4DD8C.69C34A1B@uab.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sverker Wiberg wrote:

> Over here, we started to log the conversations, and saw the client
> opening a file, writing 272 bytes into it (one write), and then closing
> it, with the server replying full success all the time. printk()'s in
> knfsd and the vfs's generic_write() also reported that 272 bytes had
> been successfully written. Yet the file was truncated.
> 
> We switched from soft to hard mount: It didn't help. We are now
> experimenting with disabling SCSI's disconnect/reconnect feature. Are
> there any more straws to grasp at?

With one single knfsd thread running, the problem went away (for a price
in performance). This seems to indicate there is some kind of race
between the knfsd threads. 

/Sverker
