Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261948AbREPNcm>; Wed, 16 May 2001 09:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbREPNcf>; Wed, 16 May 2001 09:32:35 -0400
Received: from mail.eastlink.de ([213.187.64.4]:63492 "EHLO mail.eastlink.de")
	by vger.kernel.org with ESMTP id <S261948AbREPNc1>;
	Wed, 16 May 2001 09:32:27 -0400
Message-ID: <3B0280E4.5070600@eastlink.de>
Date: Wed, 16 May 2001 15:30:12 +0200
From: Andreas Schultz <Andreas.Schultz@eastlink.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.4/2.4.5-pre2 process semi stuck in n_tty.c:write_chan
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just installed a new system using 2.4.4 and later tried 2.4.5pre2 and 
2.4.4ac6 and ac9. All versions show the same behaivior.

When doing a "cat /var/log/messages", the output slows down after the 
first 30 lines and comes to an almost complete stop, with a few lines 
showing up every 10sec or so.

A "ps -eo pid,tt,user,fname,tmout,f,nwchan,wchan" shows the process 
sitting in write_chan in n_tty.c line 1198.

I realize that this information is probably not enough to find out whats 
going on, could you please advise me on what further information is 
needed and how to get it.

Thanks

    Andreas
---- snip ----
                 if (!nr)
                         break;
                 if (file->f_flags & O_NONBLOCK) {
                         retval = -EAGAIN;
                         break;
                 }
here ===>       schedule();
         }
break_out:
         current->state = TASK_RUNNING;
         remove_wait_queue(&tty->write_wait, &wait);
         return (b - buf) ? b - buf : retval;
}
---- snip ----

