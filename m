Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312461AbSCVNqI>; Fri, 22 Mar 2002 08:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312354AbSCVNp7>; Fri, 22 Mar 2002 08:45:59 -0500
Received: from gold.muskoka.com ([216.123.107.5]:52228 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S312461AbSCVNps>;
	Fri, 22 Mar 2002 08:45:48 -0500
Message-ID: <3C9B2E98.2FE4B4A5@yahoo.com>
Date: Fri, 22 Mar 2002 08:16:08 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.7 Documentation/00-INDEX
In-Reply-To: <200203210835.51213@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> 
> This patch updates Documentation/00-INDEX. It removes some lines describing
> files that have been removed/moved to subdirectories. Also it adds some lines
> on new files/directories.
> 
> Eike

Hey, thanks.  In case you haven't automated this check already, see my $0.02
script attached below that I try to run over 00-INDEX every now and again.

> +driver.txt
> +       - info about Linux driver modell.

Should be driver-model.txt IIRC, and  s/ll/l/ too.

Paul.
--

#!/bin/sh
# For keeping an eye on 00-INDEX files in the linux/Documentation/ dir.

echo Checking for unreferenced files...
for i in * 
do 
	grep -q $i 00-INDEX 
	if [ $? = 1 ];then 
		echo $i is not in 00-INDEX 
	fi
done

echo -------------------------------------------

echo Checking for orphaned entries...

for i in `awk '/^\t- / {print FNR-1}' 00-INDEX`
do
	FNAME=`awk FNR==$i 00-INDEX`
	if [ ! -e "$FNAME" ];then
		echo $FNAME is in 00-INDEX but does not exist
	fi
done

echo Done.


