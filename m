Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSIOVN1>; Sun, 15 Sep 2002 17:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSIOVN1>; Sun, 15 Sep 2002 17:13:27 -0400
Received: from gate.in-addr.de ([212.8.193.158]:49412 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S318216AbSIOVN0>;
	Sun, 15 Sep 2002 17:13:26 -0400
Date: Sun, 15 Sep 2002 23:12:22 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Oktay Akbal <oktay.akbal@s-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Bug with MD multipath and raid1 on top
Message-ID: <20020915211222.GE8607@marowsky-bree.de>
References: <20020914230753.GA3781@marowsky-bree.de> <Pine.LNX.4.44.0209150721270.25780-100000@omega.s-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0209150721270.25780-100000@omega.s-tec.de>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-15T07:29:30,
   Oktay Akbal <oktay.akbal@s-tec.de> said:

> > Is this with or without the patch I recently posted to linux-kernel?
> 
> Since it is the latest official Suse-2.4.18 from SLES I assume this patch
> is not included.

Oh, ok. Multipathing is known to not work perfectly right in the mainstream
kernel. In this case, you might want to try the patch.

> > So far this sounds OK.
> All disks are dead. The md0 device is missing. The same should be true for
> md1, since there is no difference in setup. Why should the raid1 no report
> both mirrors as dead ?

Oh, right. I misread your mail and just saw that the md1 was also on the same
devices. Strange indeed.

> > (Even though the updated md-mp patch will _never_ fail the last path but
> > instead return the error to the layer upwards; this protects against
> > certain scenarios in 2.4 where a device error can't be distinguished from
> > a failed path and we don't want that to lead to an inaccessible device)
> How would the failing of all Pathes then be noticed ?

Well, IO errors would occur, be reported to the caller and those would
supposedly be noticed.

However, the 2.4 error reporting can't distinguish between a path or a device
error. So a failed read (destroyed block, for example) will fail a path. As
the read request is retried on all paths if necessary, it would be highly
undesireable to fail _all_ paths because of this. The last path will remain
"accessible", but the application will see an error in this case.

> This might well be, since I don't found the qlogic-driver very impressing
> so far. To use md-multipath the multipathing (failover) functionality from
> the driver was disabled.

OK. Well, I never tested the QLogic proprietary failover because I consider it
to be the wrong approach ;-) The md layer should work though by now.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

