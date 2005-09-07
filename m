Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVIGQYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVIGQYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVIGQYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:24:34 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:54223 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751234AbVIGQYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:24:34 -0400
Message-ID: <431F143F.2070904@vc.cvut.cz>
Date: Wed, 07 Sep 2005 18:24:31 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?sch=F6nfeld_/_in-medias-res?= 
	<schoenfeld@in-medias-res.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ncpfs: Connection invalid / Input-/Output Errors
References: <S932080AbVIGI45/20050907085657Z+286@vger.kernel.org>	 <431ECA16.8040104@in-medias-res.com> <1126095079.28456.18.camel@imp.csi.cam.ac.uk> <431EF5CD.9050006@in-medias-res.com>
In-Reply-To: <431EF5CD.9050006@in-medias-res.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schönfeld / in-medias-res wrote:
> Hi,
> 
> thanks for your answere.

> Uhmm... then remains the question: Why should that happen on the first
> machine but not on the second?

Enable displaying of connection watchdog logouts on the server.  Do not
use 'intr' mount option.  Do not send KILL signal to the connection
which is waiting for reply from server.  If you are not sure that your
network infrastructure is fine, use 'hard' mount option to disable
timeouts altogether.

>>To see if this is your problem, insert some printk()s in the relevant
>>ncpfs code (depends whether you are using ipx or tcp/udp as to where)
> 
> Well - i'm using IPX. So where do i insert the printk()s? And what kind
> of printk()s should i insert? Please don't think of me as an idiot,
> but i'm just not firm with "kernel hacking".

Into 'ncp_invalidate_conn()', or better, into its callers.  One is in
__abort_ncp_connection (invoked for IPX connections when
__ncpdgram_timeout_proc fires), second is in ncp_do_request (if server
reports some problem, or if KILL signal is sent to the process).
							Petr

