Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbTCaRcv>; Mon, 31 Mar 2003 12:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbTCaRcv>; Mon, 31 Mar 2003 12:32:51 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:52446 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261705AbTCaRcu>; Mon, 31 Mar 2003 12:32:50 -0500
Date: Mon, 31 Mar 2003 09:46:01 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem created by Zoning on Linux
Message-ID: <20030331174601.GA1408@beaverton.ibm.com>
Mail-Followup-To: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>,
	linux-kernel@vger.kernel.org
References: <000001c2f780$da0265e0$e9bba5cc@patni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c2f780$da0265e0$e9bba5cc@patni.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chandrasekhar.nagaraj [chandrasekhar.nagaraj@patni.com] wrote:
> But the second Host, which should have access to LUN 4 to 7, has some
> problem.
> The /proc/partitions does not show any scsi device file. Also
> /proc/scsi/scsi does not entries corresponding to LUN 4 to 7; but it have
> only one entry corresponding to LUN 0 (which should not be allowed).
> 
> So, is there any restriction on Linux that the LUN number should start with
> 0 only??
> If so, then what is the solution/workaround?

You did not mention the kernel version you are working with, but I will
assume that it is 2.4 based (2.5 supports report_luns and should avoid
this problem).

The failure looks like you need to set a sparse lun flag for this
storage device. Add an entry with the BLIST_SPARSELUN flag set to the
device_list array in scsi_scan.c for this storage device.

If the scanning is happening post boot you could turn on some scan
logging to verify this issue. 
	echo "scsi log scan 4" > /proc/scsi/scsi
You can set logging during boot, but you can only control all logging or
none and it sometimes generates to much output.

-andmike
--
Michael Anderson
andmike@us.ibm.com

