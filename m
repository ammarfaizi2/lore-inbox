Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290232AbSAOSUh>; Tue, 15 Jan 2002 13:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290222AbSAOSU2>; Tue, 15 Jan 2002 13:20:28 -0500
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:27043
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S290232AbSAOSUO>; Tue, 15 Jan 2002 13:20:14 -0500
Subject: Re: floating point exception
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.33.0201151633300.2080-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0201151633300.2080-100000@netfinity.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 15 Jan 2002 19:19:13 +0100
Message-Id: <1011118755.13266.0.camel@sector17.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-15 at 15:34, Zwane Mwaikambo wrote:
> On 14 Jan 2002, Christian Thalinger wrote:
> 
> > It seems the floating point exception is only raised with a new data
> > package. Is there a simple way to raise such a exception?
> 
> New data package? And does the same behaviour re-occur after the fpu
> exception? ie programs start segfaulting etc. Can you try doing a "dmesg"
> after the segfaults and fpu exception and see if there is anything in the
> kernel ring buffer too.
> 
> Regards,
> 	Zwane Mwaikambo
> 

There are .sah files, in which the data is stored to analyse. So i
deleted these files and the client downloads a new package -> new data
package.

Yes, it did happen that the segfault reoccured and there is nothing in
the dmesg. This was also my first thought, then checked
/var/log/messages with a tail and it stucked. No ctrl-c.

Tried this:

#define _GNU_SOURCE 1
#include <fenv.h>

main() {
    double zero=0.0;
    double one=1.0;
    
    feenableexcept(FE_ALL_EXCEPT);
    
    one /=zero;
}

...but nothing happens.

