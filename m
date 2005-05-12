Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVELIsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVELIsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVELIsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:48:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:59583 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261345AbVELIoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:44:44 -0400
Date: Thu, 12 May 2005 10:44:37 +0200 (MEST)
From: "Manfred Schwarb" <manfred99@gmx.ch>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       davem@redhat.com, netdev@oss.sgi.com
MIME-Version: 1.0
References: <E1DVyuq-0005Sf-00@gondolin.me.apana.org.au>
Subject: Re: 2.4.30-hf1 do_IRQ stack overflows
X-Priority: 3 (Normal)
X-Authenticated: #17170890
Message-ID: <21780.1115887477@www69.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > May 11 04:22:09 server kernel:   [__switch_to+82/256]
> [schedule+738/1344] [schedule_timeout+84/160] [process_timeout+0/96]
>
[st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294702743/96]
>
[st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294703097/96]
> 
> The stack trace becomes unreadable at this point.  Please run klogd
> with -X and then decode the messages with ksymoops.  Alternatively
> run ksymoops on the output of dmesg directly.
> 

Here are the 3 ksymoopsified traces (ksymoops -i):

May 11 04:22:09 tp-meteodat7 kernel: f3668824 00000274 e9a40380 00000000
00000003 f7e5d280 f3668000 0000000e
May 11 04:22:09 tp-meteodat7 kernel:        c010d948 00000003 f7e5d318
f7e5d308 f7e5d280 f3668000 0000000e 00000006
May 11 04:22:09 tp-meteodat7 kernel:        f1960018 f1a00018 ffffff14
c024893e 00000010 00000202 f7e5d280 f196cc00
May 11 04:22:09 tp-meteodat7 kernel: Call Trace:    [call_do_IRQ+5/13]
[pfifo_fast_dequeue+62/80] [qdisc_restart+31/432] [dev_queue_xmit+383/880]
[neigh_resolve_output+321/624]
May 11 04:22:09 tp-meteodat7 kernel: Call Trace:    [<c010d948>]
[<c024893e>] [<c02483df>] [<c023ccaf>] [<c0243af1>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c025a2d8>] [<c025a220>]
[<c025a220>] [<c024763e>] [<c025a220>] [<c0258a4e>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c025a220>] [<c025a445>]
[<c025a370>] [<c025a370>] [<c024763e>] [<c025a370>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c0258e2d>] [<c025a370>]
[<c023ccaf>] [<c0271c20>] [<c026bdc9>] [<c026e824>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c025d4a0>] [<c025d4a0>]
[<c026a2fa>] [<c0272eda>] [<c02735be>] [<c025581f>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c02556c0>] [<c024763e>]
[<c02556c0>] [<c025514f>] [<c02556c0>] [<c0255a89>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c0255860>] [<c0255860>]
[<c024763e>] [<c0255860>] [<c0255589>] [<c0255860>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c023d505>] [<c023d5d3>]
[<c023d76a>] [<c01254c6>] [<c010b094>] [<c010d948>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c0107722>] [<c011cee2>]
[<c011cb14>] [<c011ca60>] [<f90f0697>] [<f90f07f9>]
May 11 04:22:09 tp-meteodat7 kernel:   [<f90f08ab>] [<f90f20c6>]
[<f914d588>] [<f914f255>] [<f8b557d4>] [<f8b629ca>]
May 11 04:22:09 tp-meteodat7 kernel:   [<f8b3a3c4>] [<f8b4cc74>]
[<f8b3a3c4>] [<f8b39e28>] [<f8b448c3>] [<f8b4d47e>]
May 11 04:22:09 tp-meteodat7 kernel:   [<f8b4f8c3>] [<f8b4667b>]
[<f8b3a308>] [<f8b465ad>] [<f8b531fc>] [<c02387be>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c02387be>] [<f90dd5f4>]
[<c02483df>] [<c023ccaf>] [<c0243af1>] [<c02387be>]
May 11 04:22:09 tp-meteodat7 kernel:   [<f90dd5f4>] [<c02483df>]
[<c023ccaf>] [<c0243af1>] [<c025a2d8>] [<c025a220>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c025a220>] [<c024763e>]
[<c025a220>] [<c0258a4e>] [<c025a220>] [<c025a445>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c025a370>] [<c025a370>]
[<c024763e>] [<c025a370>] [<c0258e2d>] [<c025a370>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c02399dc>] [<c0237f63>]
[<c025d4a0>] [<c025d4a0>] [<c026a2bd>] [<c0272eda>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c02735be>] [<c01e4308>]
[<f8b20233>] [<f8b20233>] [<f8b20547>] [<f8b31d39>]
May 11 04:22:09 tp-meteodat7 kernel:   [<f8b18565>] [<f8b696b7>]
[<f8b7068b>] [<c01258ca>] [<c0125753>] [<c0158905>]
May 11 04:22:09 tp-meteodat7 kernel:   [<c0108fa7>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c010d948 <call_do_IRQ+5/d>
Trace; c024893e <pfifo_fast_dequeue+3e/50>
Trace; c02483df <qdisc_restart+1f/1b0>
Trace; c023ccaf <dev_queue_xmit+17f/370>
Trace; c0243af1 <neigh_resolve_output+141/270>
Trace; c025a2d8 <ip_finish_output2+b8/150>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c0258a4e <ip_output+14e/1e0>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c025a445 <ip_queue_xmit2+d5/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c0258e2d <ip_queue_xmit+34d/600>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c023ccaf <dev_queue_xmit+17f/370>
Trace; c0271c20 <tcp_v4_send_check+a0/f0>
Trace; c026bdc9 <tcp_transmit_skb+3e9/700>
Trace; c026e824 <tcp_send_ack+84/d0>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c026a2fa <tcp_rcv_established+7fa/a50>
Trace; c0272eda <tcp_v4_do_rcv+13a/160>
Trace; c02735be <tcp_v4_rcv+6be/7a0>
Trace; c025581f <ip_local_deliver_finish+15f/1a0>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c025514f <ip_local_deliver+18f/240>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c0255a89 <ip_rcv_finish+229/2bc>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c0255589 <ip_rcv+389/4c0>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c023d505 <netif_receive_skb+1e5/220>
Trace; c023d5d3 <process_backlog+93/130>
Trace; c023d76a <net_rx_action+fa/170>
Trace; c01254c6 <do_softirq+76/e0>
Trace; c010b094 <do_IRQ+f4/130>
Trace; c010d948 <call_do_IRQ+5/d>
Trace; c0107722 <__switch_to+52/100>
Trace; c011cee2 <schedule+2e2/540>
Trace; c011cb14 <schedule_timeout+54/a0>
Trace; c011ca60 <process_timeout+0/60>
Trace; f90f0697 <[usbcore]usb_start_wait_urb+a7/1a0>
Trace; f90f07f9 <[usbcore]usb_internal_control_msg+69/80>
Trace; f90f08ab <[usbcore]usb_control_msg+9b/b0>
Trace; f90f20c6 <[usbcore]usb_get_report+76/80>
Trace; f914d588 <[hid]hid_read_report+98/c0>
Trace; f914f255 <[hid]hiddev_ioctl+565/cd0>
Trace; f8b557d4 <[reiserfs]get_cnode+14/80>
Trace; f8b629ca <[reiserfs].LC32+57e7/5a7d>
Trace; f8b3a3c4 <[reiserfs]do_balance_mark_leaf_dirty+64/a0>
Trace; f8b4cc74 <[reiserfs]leaf_insert_into_buf+1c4/2c0>
Trace; f8b3a3c4 <[reiserfs]do_balance_mark_leaf_dirty+64/a0>
Trace; f8b39e28 <[reiserfs]balance_leaf+30a8/3120>
Trace; f8b448c3 <[reiserfs]ip_check_balance+2e3/bf0>
Trace; f8b4d47e <[reiserfs]leaf_cut_from_buffer+28e/4b0>
Trace; f8b4f8c3 <[reiserfs]pathrelse_and_restore+43/60>
Trace; f8b4667b <[reiserfs]unfix_nodes+9b/180>
Trace; f8b3a308 <[reiserfs]do_balance+d8/130>
Trace; f8b465ad <[reiserfs]fix_nodes+3fd/430>
Trace; f8b531fc <[reiserfs]reiserfs_insert_item+14c/150>
Trace; c02387be <__kfree_skb+fe/160>
Trace; c02387be <__kfree_skb+fe/160>
Trace; f90dd5f4 <[8139too]rtl8139_start_xmit+84/180>
Trace; c02483df <qdisc_restart+1f/1b0>
Trace; c023ccaf <dev_queue_xmit+17f/370>
Trace; c0243af1 <neigh_resolve_output+141/270>
Trace; c02387be <__kfree_skb+fe/160>
Trace; f90dd5f4 <[8139too]rtl8139_start_xmit+84/180>
Trace; c02483df <qdisc_restart+1f/1b0>
Trace; c023ccaf <dev_queue_xmit+17f/370>
Trace; c0243af1 <neigh_resolve_output+141/270>
Trace; c025a2d8 <ip_finish_output2+b8/150>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c0258a4e <ip_output+14e/1e0>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c025a445 <ip_queue_xmit2+d5/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c0258e2d <ip_queue_xmit+34d/600>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c02399dc <skb_checksum+5c/320>
Trace; c0237f63 <sock_def_readable+63/80>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c026a2bd <tcp_rcv_established+7bd/a50>
Trace; c0272eda <tcp_v4_do_rcv+13a/160>
Trace; c02735be <tcp_v4_rcv+6be/7a0>
Trace; c01e4308 <locate_hd_struct+38/a0>
Trace; f8b20233 <[scsi_mod]__scsi_end_request+233/240>
Trace; f8b20233 <[scsi_mod]__scsi_end_request+233/240>
Trace; f8b20547 <[scsi_mod]scsi_io_completion+1d7/4c0>
Trace; f8b31d39 <[sd_mod]rw_intr+89/2c0>
Trace; f8b18565 <[scsi_mod]scsi_finish_command+c5/110>
Trace; f8b696b7 <[libata]ata_qc_complete+37/b0>
Trace; f8b7068b <[sata_promise]pdc_interrupt+16b/1b0>
Trace; c01258ca <bh_action+6a/70>
Trace; c0125753 <tasklet_hi_action+53/a0>
Trace; c0158905 <sys_ioctl+2a5/311>
Trace; c0108fa7 <system_call+33/38>

###############################################################

May 11 04:26:28 tp-meteodat7 kernel: f3668998 000003e8 00000000 00000000
f3668000 f3668ac0 f3668a34 00000000
May 11 04:26:28 tp-meteodat7 kernel:        c010d948 f3668000 0001961a
00000944 f3668ac0 f3668a34 00000000 00000944
May 11 04:26:28 tp-meteodat7 kernel:        00000018 f1960018 ffffff14
f90820a7 00000010 00000246 f3668a34 f40a9ec0
May 11 04:26:28 tp-meteodat7 kernel: Call Trace:    [call_do_IRQ+5/13]
[st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294250663/96]
[st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294268736/96]
[st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294250842/96]
[st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294254302/96]
May 11 04:26:28 tp-meteodat7 kernel: Call Trace:    [<c010d948>]
[<f90820a7>] [<f9086740>] [<f908215a>] [<f9082ede>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c025a370>] [<c0247185>]
[<c025a370>] [<c025a370>] [<c0247557>] [<c025a370>]
May 11 04:26:28 tp-meteodat7 kernel:   [<f9085fb8>] [<c0258e2d>]
[<c025a370>] [<c02735be>] [<c0271c20>] [<c026bdc9>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c026e824>] [<c025d4a0>]
[<c025d4a0>] [<c026a2fa>] [<c0272eda>] [<c02735be>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c025581f>] [<c02556c0>]
[<c024763e>] [<c02556c0>] [<c025514f>] [<c02556c0>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c0255a89>] [<c0255860>]
[<c0255860>] [<c024763e>] [<c0255860>] [<c0255589>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c0255860>] [<c023d505>]
[<c023d5d3>] [<c023d76a>] [<c01254c6>] [<c010b094>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c010d948>] [<f90f0018>]
[<f914e620>] [<f914e7b6>] [<f914d473>] [<f914d5a6>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c018480b>] [<f914f255>]
[<f8b557d4>] [<f8b629ca>] [<f8b3a3c4>] [<f8b4cc74>]
May 11 04:26:28 tp-meteodat7 kernel:   [<f8b3a3c4>] [<f8b39e28>]
[<f8b448c3>] [<f8b4d47e>] [<f8b4f8c3>] [<f8b4667b>]
May 11 04:26:28 tp-meteodat7 kernel:   [<f8b3a308>] [<f8b465ad>]
[<f8b531fc>] [<c02387be>] [<c02387be>] [<c02387be>]
May 11 04:26:28 tp-meteodat7 kernel:   [<f90dd5f4>] [<c02483df>]
[<c023ccaf>] [<c0243af1>] [<c025a2d8>] [<c025a220>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c025a220>] [<c024763e>]
[<c025a220>] [<c0258a4e>] [<c025a220>] [<c025a445>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c025a370>] [<c025a370>]
[<c024763e>] [<c025a370>] [<c0258e2d>] [<c025a370>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c024763e>] [<c0271c20>]
[<c026bdc9>] [<c0237f63>] [<c025d4a0>] [<c025d4a0>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c026a2bd>] [<c0272eda>]
[<c02735be>] [<c025581f>] [<c02556c0>] [<c024763e>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c02556c0>] [<c025514f>]
[<c02556c0>] [<c0255a89>] [<c0255860>] [<c0255860>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c024763e>] [<c011cee2>]
[<c011cb1e>] [<c01594d4>] [<c01598d9>] [<c0159bb4>]
May 11 04:26:28 tp-meteodat7 kernel:   [<c0158905>] [<c0124bb5>]
[<c0108fa7>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c010d948 <call_do_IRQ+5/d>
Trace; f90820a7 <[ip_conntrack]__ip_conntrack_find+17/90>
Trace; f9086740 <[ip_conntrack]ip_conntrack_protocol_tcp+0/40>
Trace; f908215a <[ip_conntrack]ip_conntrack_find_get+3a/80>
Trace; f9082ede <[ip_conntrack]ip_conntrack_in+1ae/2e0>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c0247185 <nf_iterate+55/a0>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c0247557 <nf_hook_slow+f7/210>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; f9085fb8 <[ip_conntrack]ip_conntrack_local_out_ops+0/18>
Trace; c0258e2d <ip_queue_xmit+34d/600>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c02735be <tcp_v4_rcv+6be/7a0>
Trace; c0271c20 <tcp_v4_send_check+a0/f0>
Trace; c026bdc9 <tcp_transmit_skb+3e9/700>
Trace; c026e824 <tcp_send_ack+84/d0>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c026a2fa <tcp_rcv_established+7fa/a50>
Trace; c0272eda <tcp_v4_do_rcv+13a/160>
Trace; c02735be <tcp_v4_rcv+6be/7a0>
Trace; c025581f <ip_local_deliver_finish+15f/1a0>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c025514f <ip_local_deliver+18f/240>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c0255a89 <ip_rcv_finish+229/2bc>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c0255589 <ip_rcv+389/4c0>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c023d505 <netif_receive_skb+1e5/220>
Trace; c023d5d3 <process_backlog+93/130>
Trace; c023d76a <net_rx_action+fa/170>
Trace; c01254c6 <do_softirq+76/e0>
Trace; c010b094 <do_IRQ+f4/130>
Trace; c010d948 <call_do_IRQ+5/d>
Trace; f90f0018 <[usbcore]call_policy_interface+8/260>
Trace; f914e620 <[hid]hiddev_send_event+0/b0>
Trace; f914e7b6 <[hid]hiddev_report_event+66/80>
Trace; f914d473 <[hid]hid_input_report+133/170>
Trace; f914d5a6 <[hid]hid_read_report+b6/c0>
Trace; c018480b <isofs_read_super+46b/800>
Trace; f914f255 <[hid]hiddev_ioctl+565/cd0>
Trace; f8b557d4 <[reiserfs]get_cnode+14/80>
Trace; f8b629ca <[reiserfs].LC32+57e7/5a7d>
Trace; f8b3a3c4 <[reiserfs]do_balance_mark_leaf_dirty+64/a0>
Trace; f8b4cc74 <[reiserfs]leaf_insert_into_buf+1c4/2c0>
Trace; f8b3a3c4 <[reiserfs]do_balance_mark_leaf_dirty+64/a0>
Trace; f8b39e28 <[reiserfs]balance_leaf+30a8/3120>
Trace; f8b448c3 <[reiserfs]ip_check_balance+2e3/bf0>
Trace; f8b4d47e <[reiserfs]leaf_cut_from_buffer+28e/4b0>
Trace; f8b4f8c3 <[reiserfs]pathrelse_and_restore+43/60>
Trace; f8b4667b <[reiserfs]unfix_nodes+9b/180>
Trace; f8b3a308 <[reiserfs]do_balance+d8/130>
Trace; f8b465ad <[reiserfs]fix_nodes+3fd/430>
Trace; f8b531fc <[reiserfs]reiserfs_insert_item+14c/150>
Trace; c02387be <__kfree_skb+fe/160>
Trace; c02387be <__kfree_skb+fe/160>
Trace; c02387be <__kfree_skb+fe/160>
Trace; f90dd5f4 <[8139too]rtl8139_start_xmit+84/180>
Trace; c02483df <qdisc_restart+1f/1b0>
Trace; c023ccaf <dev_queue_xmit+17f/370>
Trace; c0243af1 <neigh_resolve_output+141/270>
Trace; c025a2d8 <ip_finish_output2+b8/150>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c0258a4e <ip_output+14e/1e0>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c025a445 <ip_queue_xmit2+d5/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c0258e2d <ip_queue_xmit+34d/600>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c0271c20 <tcp_v4_send_check+a0/f0>
Trace; c026bdc9 <tcp_transmit_skb+3e9/700>
Trace; c0237f63 <sock_def_readable+63/80>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c026a2bd <tcp_rcv_established+7bd/a50>
Trace; c0272eda <tcp_v4_do_rcv+13a/160>
Trace; c02735be <tcp_v4_rcv+6be/7a0>
Trace; c025581f <ip_local_deliver_finish+15f/1a0>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c025514f <ip_local_deliver+18f/240>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c0255a89 <ip_rcv_finish+229/2bc>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c011cee2 <schedule+2e2/540>
Trace; c011cb1e <schedule_timeout+5e/a0>
Trace; c01594d4 <poll_freewait+44/50>
Trace; c01598d9 <do_select+239/250>
Trace; c0159bb4 <sys_select+294/4e0>
Trace; c0158905 <sys_ioctl+2a5/311>
Trace; c0124bb5 <sys_time+15/50>
Trace; c0108fa7 <system_call+33/38>

################################################################

May 11 04:30:06 tp-meteodat7 kernel: f3668830 00000280 f2c73080 00000000
f196cd80 d2029180 d2029180 00000042
May 11 04:30:06 tp-meteodat7 kernel:        c010d948 f196cd80 f008a0ec
d2029180 d2029180 d2029180 00000042 f008a080
May 11 04:30:06 tp-meteodat7 kernel:        f1960018 f5fd0018 ffffff14
c0238723 00000010 00000202 d2029180 d2029180
May 11 04:30:06 tp-meteodat7 kernel: Call Trace:    [call_do_IRQ+5/13]
[__kfree_skb+99/352]
[st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294624756/96]
[qdisc_restart+114/432] [dev_queue_xmit+383/880]
May 11 04:30:06 tp-meteodat7 kernel: Call Trace:    [<c010d948>]
[<c0238723>] [<f90dd5f4>] [<c0248432>] [<c023ccaf>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c025a2d8>] [<c025a220>]
[<c025a220>] [<c024763e>] [<c025a220>] [<c0258a4e>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c025a220>] [<c025a445>]
[<c025a370>] [<c025a370>] [<c024763e>] [<c025a370>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c0258e2d>] [<c025a370>]
[<c0271c20>] [<c026bdc9>] [<c026e824>] [<c025d4a0>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c025d4a0>] [<c026a2fa>]
[<c0272eda>] [<c02735be>] [<c025581f>] [<c02556c0>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c024763e>] [<c02556c0>]
[<c025514f>] [<c02556c0>] [<c0255a89>] [<c0255860>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c0255860>] [<c024763e>]
[<c0255860>] [<c0255589>] [<c0255860>] [<c023d505>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c023d5d3>] [<c023d76a>]
[<c01254c6>] [<c010b094>] [<c010d948>] [<f9109ae3>]
May 11 04:30:06 tp-meteodat7 kernel:   [<f910a404>] [<f910be18>]
[<f90f058d>] [<f90f066d>] [<f90f07f9>] [<f90f08ab>]
May 11 04:30:06 tp-meteodat7 kernel:   [<f90f20c6>] [<f914d588>]
[<c018480b>] [<f914f255>] [<f8b557d4>] [<f8b629ca>]
May 11 04:30:06 tp-meteodat7 kernel:   [<f8b3a3c4>] [<f8b4cc74>]
[<f8b3a3c4>] [<f8b39e28>] [<f8b448c3>] [<f8b4d47e>]
May 11 04:30:06 tp-meteodat7 kernel:   [<f8b4f8c3>] [<f8b4667b>]
[<f8b3a308>] [<f8b465ad>] [<f8b531fc>] [<c02387be>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c023cfb3>] [<f90ddb21>]
[<f90dd5f4>] [<c02387be>] [<f90dd5f4>] [<c02387be>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c02387be>] [<f90dd5f4>]
[<c02483df>] [<c023ccaf>] [<c025a2d8>] [<c025a220>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c025a220>] [<c024763e>]
[<c025a220>] [<c0258a4e>] [<c025a220>] [<c025a445>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c025a370>] [<c025a370>]
[<c024763e>] [<c025a370>] [<c0258e2d>] [<c025a370>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c0237f63>] [<c025d4a0>]
[<c025d4a0>] [<c026a2bd>] [<c0272eda>] [<c02735be>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c025581f>] [<c02556c0>]
[<c024763e>] [<c02556c0>] [<c025514f>] [<c02556c0>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c0255a89>] [<c013e624>]
[<c01594d4>] [<c01598d9>] [<c0159bb4>] [<c0158905>]
May 11 04:30:06 tp-meteodat7 kernel:   [<c0124bb5>] [<c0108fa7>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c010d948 <call_do_IRQ+5/d>
Trace; c0238723 <__kfree_skb+63/160>
Trace; f90dd5f4 <[8139too]rtl8139_start_xmit+84/180>
Trace; c0248432 <qdisc_restart+72/1b0>
Trace; c023ccaf <dev_queue_xmit+17f/370>
Trace; c025a2d8 <ip_finish_output2+b8/150>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c0258a4e <ip_output+14e/1e0>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c025a445 <ip_queue_xmit2+d5/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c0258e2d <ip_queue_xmit+34d/600>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c0271c20 <tcp_v4_send_check+a0/f0>
Trace; c026bdc9 <tcp_transmit_skb+3e9/700>
Trace; c026e824 <tcp_send_ack+84/d0>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c026a2fa <tcp_rcv_established+7fa/a50>
Trace; c0272eda <tcp_v4_do_rcv+13a/160>
Trace; c02735be <tcp_v4_rcv+6be/7a0>
Trace; c025581f <ip_local_deliver_finish+15f/1a0>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c025514f <ip_local_deliver+18f/240>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c0255a89 <ip_rcv_finish+229/2bc>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c0255589 <ip_rcv+389/4c0>
Trace; c0255860 <ip_rcv_finish+0/2bc>
Trace; c023d505 <netif_receive_skb+1e5/220>
Trace; c023d5d3 <process_backlog+93/130>
Trace; c023d76a <net_rx_action+fa/170>
Trace; c01254c6 <do_softirq+76/e0>
Trace; c010b094 <do_IRQ+f4/130>
Trace; c010d948 <call_do_IRQ+5/d>
Trace; f9109ae3 <[usb-uhci]insert_qh+83/c0>
Trace; f910a404 <[usb-uhci]uhci_submit_control_urb+244/370>
Trace; f910be18 <[usb-uhci]uhci_submit_urb+3c8/400>
Trace; f90f058d <[usbcore]usb_submit_urb+3d/40>
Trace; f90f066d <[usbcore]usb_start_wait_urb+7d/1a0>
Trace; f90f07f9 <[usbcore]usb_internal_control_msg+69/80>
Trace; f90f08ab <[usbcore]usb_control_msg+9b/b0>
Trace; f90f20c6 <[usbcore]usb_get_report+76/80>
Trace; f914d588 <[hid]hid_read_report+98/c0>
Trace; c018480b <isofs_read_super+46b/800>
Trace; f914f255 <[hid]hiddev_ioctl+565/cd0>
Trace; f8b557d4 <[reiserfs]get_cnode+14/80>
Trace; f8b629ca <[reiserfs].LC32+57e7/5a7d>
Trace; f8b3a3c4 <[reiserfs]do_balance_mark_leaf_dirty+64/a0>
Trace; f8b4cc74 <[reiserfs]leaf_insert_into_buf+1c4/2c0>
Trace; f8b3a3c4 <[reiserfs]do_balance_mark_leaf_dirty+64/a0>
Trace; f8b39e28 <[reiserfs]balance_leaf+30a8/3120>
Trace; f8b448c3 <[reiserfs]ip_check_balance+2e3/bf0>
Trace; f8b4d47e <[reiserfs]leaf_cut_from_buffer+28e/4b0>
Trace; f8b4f8c3 <[reiserfs]pathrelse_and_restore+43/60>
Trace; f8b4667b <[reiserfs]unfix_nodes+9b/180>
Trace; f8b3a308 <[reiserfs]do_balance+d8/130>
Trace; f8b465ad <[reiserfs]fix_nodes+3fd/430>
Trace; f8b531fc <[reiserfs]reiserfs_insert_item+14c/150>
Trace; c02387be <__kfree_skb+fe/160>
Trace; c023cfb3 <netif_rx+93/1f0>
Trace; f90ddb21 <[8139too]rtl8139_rx_interrupt+131/320>
Trace; f90dd5f4 <[8139too]rtl8139_start_xmit+84/180>
Trace; c02387be <__kfree_skb+fe/160>
Trace; f90dd5f4 <[8139too]rtl8139_start_xmit+84/180>
Trace; c02387be <__kfree_skb+fe/160>
Trace; c02387be <__kfree_skb+fe/160>
Trace; f90dd5f4 <[8139too]rtl8139_start_xmit+84/180>
Trace; c02483df <qdisc_restart+1f/1b0>
Trace; c023ccaf <dev_queue_xmit+17f/370>
Trace; c025a2d8 <ip_finish_output2+b8/150>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c0258a4e <ip_output+14e/1e0>
Trace; c025a220 <ip_finish_output2+0/150>
Trace; c025a445 <ip_queue_xmit2+d5/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c0258e2d <ip_queue_xmit+34d/600>
Trace; c025a370 <ip_queue_xmit2+0/29f>
Trace; c0237f63 <sock_def_readable+63/80>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c025d4a0 <tcp_rfree+0/20>
Trace; c026a2bd <tcp_rcv_established+7bd/a50>
Trace; c0272eda <tcp_v4_do_rcv+13a/160>
Trace; c02735be <tcp_v4_rcv+6be/7a0>
Trace; c025581f <ip_local_deliver_finish+15f/1a0>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c024763e <nf_hook_slow+1de/210>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c025514f <ip_local_deliver+18f/240>
Trace; c02556c0 <ip_local_deliver_finish+0/1a0>
Trace; c0255a89 <ip_rcv_finish+229/2bc>
Trace; c013e624 <__alloc_pages+64/280>
Trace; c01594d4 <poll_freewait+44/50>
Trace; c01598d9 <do_select+239/250>
Trace; c0159bb4 <sys_select+294/4e0>
Trace; c0158905 <sys_ioctl+2a5/311>
Trace; c0124bb5 <sys_time+15/50>
Trace; c0108fa7 <system_call+33/38>

-- 
+++ Lassen Sie Ihren Gedanken freien Lauf... z.B. per FreeSMS +++
GMX bietet bis zu 100 FreeSMS/Monat: http://www.gmx.net/de/go/mail
