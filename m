Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131001AbQKKArX>; Fri, 10 Nov 2000 19:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132023AbQKKArN>; Fri, 10 Nov 2000 19:47:13 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:25903 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131001AbQKKArG>; Fri, 10 Nov 2000 19:47:06 -0500
Message-ID: <3A0C96FD.8441F995@linux.com>
Date: Fri, 10 Nov 2000 16:46:53 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: sendmail-bugs@sendmail.org, linux-kernel@vger.kernel.org
Subject: Re: Wild thangs, was: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue
In-Reply-To: <3A0C427A.E015E58A@timpanogas.org> <20001110095227.A15010@sendmail.com> <3A0C37FF.23D7B69@timpanogas.org> <20001110101138.A15087@sendmail.com> <3A0C3F30.F5EB076E@timpanogas.org> <20001110133431.A16169@sendmail.com> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <3A0C929B.EE6F7137@linux.com> <3A0C9277.273FA907@timpanogas.org>
Content-Type: multipart/mixed;
 boundary="------------DBD1E1B304B0907EFB0BC025"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DBD1E1B304B0907EFB0BC025
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

To be honest Jeff, most of my sendmail systems have default load values
and large (read created by microsoft mua) emails make it through
constantly with no distinguishable delays.  I just launched 45 "cat
core|mail david@kalifornia.com" and core is a 10 meg binary file.  It
results in a 14 meg total message size.

The load spiked to .75 and dropped back to .45 while launching.  I started
them two minutes ago and they are all in client DATA phase with the remote
MTA at the moment.  I only have 30K/s upstream.

At present the load is .10 and the net is hopping.  This isn't a power box
and the rest of the system is running as well.

My guess is that the system reporting the problem has an elevated load
average from those 11 modprobes stuck in D state.

I manage servers that transport hundreds of thousands of emails daily and
their load is minimal.  They handle large messages fine.  The only
defaults I've really had to change are the max children and some of the
timing simply because I want stalled connections (read routing loss) to
requeue quickly.

-d


"Jeff V. Merkey" wrote:

> David Ford wrote:
>
> David,
>
> We got to the bottom of it.  sendmail is using a BSD method to react to
> load average which is different than what linux is providing.  You have
> to crank up
>
> O QueueLA = 18
> O RefuseLA = 12
>
> on a busy Linux server since the defaults will result in large emails
> never getting sent.
>
> Jeff

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------DBD1E1B304B0907EFB0BC025
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------DBD1E1B304B0907EFB0BC025--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
