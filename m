Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264202AbUD0QLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbUD0QLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUD0QLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:11:52 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:61692 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264202AbUD0QLq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:11:46 -0400
Subject: Re: Unable to read UDF fs on a DVD
From: Pat LaVarre <p.lavarre@ieee.org>
To: gerrit.scholl@philips.com
Cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org,
       linux_udf@hpesjro.fc.hp.com
In-Reply-To: <OFA36FDF30.41353846-ONC1256E83.0039A57A-C1256E83.003B5183@phil
	i ps.com>
References: <OFA36FDF30.41353846-ONC1256E83.0039A57A-C1256E83.003B5183@phili
	 ps.com>
Content-Type: text/plain;
	charset=UTF-8
Organization: 
Message-Id: <1083082286.6562.55.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Apr 2004 10:11:26 -0600
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Apr 2004 16:11:44.0935 (UTC) FILETIME=[55B9CB70:01
	C42C72]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:25.51745 C:49 M:0 S:6 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three points:

1)

> > I remember separately I saw the ... guess that the
> > unamerican chars were at issue: maybe the truthful or slanderous
> > rumours of UDF in 2004 tripping over unamerican chars as often as
> > other software does have substance.
> 
> I do not know what 'unamerican chars' problem there could be in:
>  
> > http://web.tiscali.it/kronoz/ucf_test.log

Same as you, I do not yet understand, but:

The rumour of unamerican char troubles in UDF implementations reached
this thread without coming from me.  From others we have, in the
subscriber-only linux_udf@h... archives:

-----
Cc: linux_udf@h...
Subject: Re: Unable to read UDF fs on a DVD
Date: 23 Apr 2004 14:15:10 -0600

On Fri, Apr 23, 2004 at 09:50:04PM +0200, ... wrote:
> 
> I used udfct utility (from Philips). The output is quite long, I put it
> here:
> 
> http://web.tiscali.it/kronoz/ucf_test.log

Ok, that confirmed my guess as to what the problem is (it's a problem
with 16 bit characters vs 8 bit characters)

I'll work up a patch this weekend.
...
-----

2)

My local records tell me no patch has reached `cvs co udf` or `cvs co
udftools` at sourceforge.net/linux-udf/ since 2004-03-22.

3)

I say "unamerican chars" to mean the printable chars that do not appear
on a US keyboard, even when lowercased.  Do you prefer some other term?

I can't be sure how literally the authority quoted above meant 16 vs. 8
bit.  For example, I fear together all of:

$'\x23' # "octothorpe"
$'\xA3' £ "pound sterling, ... Italian lira, ... etc."
$'\xA5' ¥ "YEN SIGN"
$'\xE2\x82\xAC' x20AC € "EURO SIGN"

Yet only the x20AC of these four chars is unequivocally not "8 bit".

The char names I quote I took from http://www.unicode.org/charts/

The arcane $'\xXX\xXX\xXX' UTF-8 notation is from `man bash` re \xHH.

Pat LaVarre

