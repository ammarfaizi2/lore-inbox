Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267955AbTB1PTs>; Fri, 28 Feb 2003 10:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbTB1PTr>; Fri, 28 Feb 2003 10:19:47 -0500
Received: from mail.ithnet.com ([217.64.64.8]:10254 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S267974AbTB1PSv>;
	Fri, 28 Feb 2003 10:18:51 -0500
Date: Fri, 28 Feb 2003 16:28:41 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Message-Id: <20030228162841.17ac0092.skraw@ithnet.com>
In-Reply-To: <20030227221017.4291c1f6.skraw@ithnet.com>
References: <20030227221017.4291c1f6.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2003 22:10:17 +0100
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> >>EIP; c0213ab3 <idescsi_pc_intr+63/360>   <=====

Additional comment:

This oops is reproducable at my system. I tried today again, and again it
happened on the same EIP. If I got that right it is this code:


                if (status.b.check)
                        rq->errors++;
                idescsi_end_request(drive, 1);
                return ide_stopped;
        }

Obviously rq is somehow damaged. I tried to retrieve further info by adding:

/* $$$ */
                local_irq_enable();
                printk("scsi: %08lx, pc: %08lx, rq: %08lx\n",scsi,pc,rq);
                if (status.b.check)
                        rq->errors++;
                idescsi_end_request(drive, 1);
                return ide_stopped;
        }

Interestingly there are about 10 lines in syslog with this output, then it
stops for around 10-20 seconds, and _then_ it oops'es. I got the feeling that
this "late" rq is indeed long gone, when the code is entered.
I tried to patch a bit around this problem, but no success at this time...

-- 
Regards,
Stephan
