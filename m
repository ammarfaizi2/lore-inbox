Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280799AbRKTAPt>; Mon, 19 Nov 2001 19:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280804AbRKTAPl>; Mon, 19 Nov 2001 19:15:41 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:63504 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280799AbRKTAPc>;
	Mon, 19 Nov 2001 19:15:32 -0500
Date: Mon, 19 Nov 2001 17:13:20 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] pcihpview 0.2
Message-ID: <20011119171320.A2582@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
X-Message-Flag: Message text blocked: Unsuitable for Adults
Reply-By: Tue, 23 Oct 2001 00:04:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Now that a number of people are actually using the PCI Hotplug driver in
the kernel, I've received quite a few requests to enable the old GUI
tools to work with the new file system interface.  Since my statements
of "it's a filesystem, use the shell" fell on deaf ears, I hacked up a
small gtk+ program called pcihpview.

It can be found at:
	http://www.kroah.com/linux/hotplug/pcihpview-0.2.tar.gz

More info on the program (but not much), and the obligatory screenshot
can be found at:
	http://www.kroah.com/linux/hotplug/

For those who just want to use a shell script, I've attached an example
of one below (it's read only, pcihpview allows you to change values.)

thanks,

greg k-h

------------------cut here------------------------
#!/bin/sh

if [ $# != "1" ] ; then
	echo
	echo "Program to display the PCI Hotplug slot information"
	echo "usage: $0 <directory>"
	echo
	exit 1
fi

DIR=$1
cd $DIR
echo "Slot	Adapter		Attention	Latch	Power"

for SLOT in * ; do
	cd $SLOT
	TEMP=`cat adapter`
	if [ $TEMP == 0 ]; then
		ADAPTER="not present"
	else
		ADAPTER="present	"
	fi

	TEMP=`cat attention`
	if [ $TEMP == 0 ]; then
		ATTENTION="off"
	else
		ATTENTION="on"
	fi

	TEMP=`cat latch`
	if [ $TEMP == 0 ]; then
		LATCH="off"
	else
		LATCH="on"
	fi

	TEMP=`cat power`
	if [ $TEMP == 0 ]; then
		POWER="off"
	else
		POWER="on"
	fi

	echo "$SLOT	$ADAPTER	$ATTENTION		$LATCH	$POWER"
	cd ..
done

	
