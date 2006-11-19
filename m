Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932824AbWKSSth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbWKSSth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932832AbWKSSth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:49:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58835 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932824AbWKSStg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:49:36 -0500
Subject: Re: [e-mail problems] with infradead.org recipients
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Oleg Verych <olecom@flower.upol.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <45609CA9.8030806@garzik.org>
References: <slrnem0qco.fp5.olecom@flower.upol.cz>
	 <45609CA9.8030806@garzik.org>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 18:49:33 +0000
Message-Id: <1163962173.6925.70.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 13:04 -0500, Jeff Garzik wrote:
> I bet this is greylisting on infradead.org.  Greylisting will put 
> unknown IPs into a database, and /temporarily/ reject the mail, asking 
> for the remote mail server to queue it.  Once $GREYLIST_TIME has passed, 
> infradead.org will accept the email.  This successfully filters out a 
> lot of spammers, and broken SMTP servers that have broken retransmit 
> [rules].
> 
> You probably need to fix the mail server delivering the mails to 
> properly retransmit...

I'm not sure that's the problem. We only greylist mail which actually
looks suspicious in the first place -- if it isn't HTML and doesn't have
any SpamAssassin points (and doesn't offend in a bunch of other ways)
then it wouldn't get greylisted. And if if _was_ greylisting, then the
first time your mail host is seen to actually retry and get the mail
through then we'll never defer mail from that IP address again.

I don't see either of those connection attempts in the logs for
canuck.infradead.org. Canuck is on GMT-5, and I've looked in its logs
for a few minutes around 08:27 and around 06:49. Nothing seems to match
your sender address.

I suspect your mail host isn't even _trying_ to make an SMTP connection;
perhaps because I publish IPv6 addresses for each of my MX hosts. I've
seen that kind of brokenness from Postfix in the past -- what MTA are
you using? If you claim my mail server rejected it, please show the
rejection message.

Please show your own mailserver logs with the alleged delivery attempt.
Here's mine from canuck (with _valid_ incoming mail elided). Although in
fact you should have been delivering to pentafluge.infradead.org in
Arjan's case, not canuck. I don't see anything relevant in pentafluge's
log either.

2006-11-19 06:48:43 1GllA6-0005Ea-KL H=chello087206226045.chello.pl (brf.org) [87.206.226.45] F=<yim@brf.org> rejected after DATA: Rejected for spam score 16.8
2006-11-19 06:49:43 SMTP command timeout on connection from mailgw0.mh.bbc.co.uk [132.185.144.140]
2006-11-19 06:49:47 H=(usconnect.com) [216.117.140.134] F=<> rejected RCPT <mueth@lists.infradead.org>: Unknown recipient
2006-11-19 06:50:58 no host name found for IP address 61.55.197.227
2006-11-19 06:50:59 H=(iwon.com) [61.55.197.227] F=<Louisa@iwon.com> rejected RCPT <berk@lists.infradead.org>: Unknown recipient
2006-11-19 06:51:00 unexpected disconnection while reading SMTP command from (iwon.com) [61.55.197.227]
2006-11-19 06:51:42 H=p54895b68.dip.t-dialin.net (localhost) [84.137.91.104] F=<sopadelua.com@kumikazi.com> rejected RCPT <arjan@pentafluge.srs.infradead.org>: Invalid SRS 
bounce 
2006-11-19 06:51:42 unexpected disconnection while reading SMTP command from p54895b68.dip.t-dialin.net (localhost) [84.137.91.104]
2006-11-19 06:52:00 Start queue run: pid=20206
2006-11-19 06:52:06 no host name found for IP address 221.210.247.158
2006-11-19 06:52:07 H=218-163-197-239.dynamic.hinet.net (chsupply.com) [218.163.197.239] sender verify fail for <seai@chsupply.com>: response to "RCPT TO:<seai@chsupply.com
>" from mail.chsupply.com [216.218.233.200] was: 550-"The recipient cannot be verified.  Please check all recipients of this\n550 message to verify they are valid."
2006-11-19 06:52:07 H=218-163-197-239.dynamic.hinet.net (chsupply.com) [218.163.197.239] F=<seai@chsupply.com> rejected RCPT <ralphs@netwinder.org>: Sender verify failed
2006-11-19 06:52:07 unexpected disconnection while reading SMTP command from 218-163-197-239.dynamic.hinet.net (chsupply.com) [218.163.197.239]
2006-11-19 06:52:09 H=(csh.cl) [221.210.247.158] F=<Curt@csh.cl> rejected RCPT <berk@lists.infradead.org>: Unknown recipient
2006-11-19 06:52:13 unexpected disconnection while reading SMTP command from (csh.cl) [221.210.247.158]



2006-11-19 08:25:42 H=(209.217.80.40) [222.98.142.147] sender verify fail for <hafnium389@hotmail.co.jp>: response to "RCPT TO:<hafnium389@hotmail.co.jp>" from mx3.hotmail.
com [65.54.244.200] was: 550 Requested action not taken: mailbox unavailable
2006-11-19 08:25:42 H=(209.217.80.40) [222.98.142.147] F=<hafnium389@hotmail.co.jp> rejected RCPT <netwinder-owner@netwinder.org>: Sender verify failed
2006-11-19 08:25:42 unexpected disconnection while reading SMTP command from (209.217.80.40) [222.98.142.147]
2006-11-19 08:26:41 H=mail.innsbrook-resort.com (Exchange2003.server2k) [66.140.223.30] F=<> rejected RCPT <plam@lists.infradead.org>: Unknown recipient
2006-11-19 08:27:19 no IP address found for host 49.red-81-184-84.user.auna.net (during SMTP connection from [81.184.84.49])
2006-11-19 08:27:19 H=(x-42gmzj0hwsvtp) [81.184.84.49] F=<qlggwrwpzdt@australiamail.com> rejected RCPT <fkha9fj8hee5k0hc@wil.cx>: Unknown user at virtual domain
2006-11-19 08:27:32 1Glmhi-0005xG-SF H=c30c.kam.pl (y1ul.bm9o11.comcast.net) [213.77.60.12] Warning: Accepting incoming message with 6.9 SA points
2006-11-19 08:27:32 1Glmhi-0005xG-SF H=c30c.kam.pl (y1ul.bm9o11.comcast.net) [213.77.60.12] F=<casebookcomputation@xpedite.fr> temporarily rejected after DATA: Greylisted <
71471623398081.85F29338EF@RAC16A> for offences: Message has 6.9 SpamAssassin points,Message appears to have HTML content, not just plain text.,:success
2006-11-19 08:27:44 H=c30c.kam.pl (DOM.cuei9.net) [213.77.60.12] sender verify fail for <bookadsorbate@yachtsmiths.com>: response to "RCPT TO:<bookadsorbate@yachtsmiths.com
>" from mx10.yachtsmiths.com [65.39.254.20] was: 511 sorry, no mailbox here by that name (#5.1.1 - chkuser)
2006-11-19 08:27:44 H=c30c.kam.pl (DOM.cuei9.net) [213.77.60.12] F=<bookadsorbate@yachtsmiths.com> rejected RCPT <linux-parport@lists.infradead.org>: Sender verify failed
2006-11-19 08:27:44 H=c30c.kam.pl (DOM.cuei9.net) [213.77.60.12] sender verify fail for <bookadsorbate@yachtsmiths.com>
2006-11-19 08:27:44 H=c30c.kam.pl (DOM.cuei9.net) [213.77.60.12] F=<bookadsorbate@yachtsmiths.com> rejected RCPT <linux-mtd@lists.infradead.org>: Sender verify failed
2006-11-19 08:27:44 unexpected disconnection while reading SMTP command from c30c.kam.pl (DOM.cuei9.net) [213.77.60.12]
2006-11-19 08:27:53 1Glmi4-0005xj-00 H=c30c.kam.pl (ufonow.8dyii.optonline.net) [213.77.60.12] Warning: Accepting incoming message with 6.5 SA points
2006-11-19 08:27:53 1Glmi4-0005xj-00 H=c30c.kam.pl (ufonow.8dyii.optonline.net) [213.77.60.12] F=<dedicatecurd@xlteam.net> temporarily rejected after DATA: Greylisted <7883
9197955556.DD633ADF78@NOB7A> for offences: Message has 6.5 SpamAssassin points,Message appears to have HTML content, not just plain text.,:success
2006-11-19 08:28:16 1GlmiT-0005xm-UC H=c30c.kam.pl (DOM.tio4s5u.net) [213.77.60.12] Warning: Accepting incoming message with 6.5 SA points
2006-11-19 08:28:16 1GlmiT-0005xm-UC H=c30c.kam.pl (DOM.tio4s5u.net) [213.77.60.12] F=<aprdignify@xece.com> temporarily rejected after DATA: Greylisted <33803317724693.CE55
931801@ZGCHVT6> for offences: Message has 6.5 SpamAssassin points,Message appears to have HTML content, not just plain text.,:success
2006-11-19 08:28:45 no host name found for IP address 125.249.82.2
2006-11-19 08:28:48 no IP address found for host 61.17.198.92.static.vsnl.net.in (during SMTP connection from [61.17.198.92])
2006-11-19 08:28:49 H=(209.217.80.40) [125.249.82.2] F=<Ralph.Rice@msa.hinet.net> rejected RCPT <info@netwinder.org>: Host 125.249.82.2 is listed in list.dsbl.org blacklist
2006-11-19 08:28:51 H=(61.17.198.92.static.vsnl.net.in) [61.17.198.92] sender verify defer for <deborahre@brightbrown.com>: response to "RCPT TO:<deborahre@brightbrown.com>
" from mail.brightbrown.com [69.20.102.99] was: 451 4.7.1 Please try again later


-- 
dwmw2

