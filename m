Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277942AbRKDUs0>; Sun, 4 Nov 2001 15:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278823AbRKDUsS>; Sun, 4 Nov 2001 15:48:18 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:56483 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277942AbRKDUr7>;
	Sun, 4 Nov 2001 15:47:59 -0500
Date: Sun, 04 Nov 2001 20:47:53 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: =?ISO-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <625740430.1004906873@[195.224.237.69]>
In-Reply-To: <20011104211153.V14001@unthought.net>
In-Reply-To: <20011104211153.V14001@unthought.net>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Using a ioctl that returns the type.
>
> But that's not pretty   :)
>
> Can't we think of something else ?

Well this sure isn't perfect, but to
illustrate it can be done with a text
interface (and the only restriction
is strings can't contain \n):

cat /proc/widget
# Format: '%l'
# Params: Number_of_Widgets
37

echo '38' > /proc/widget

cat /proc/widget
# Format: '%l'
# Params: Number_of_Widgets
38

cat /proc/widget | egrep -v '^#'
38

cat /proc/sprocket
# Format: '%l' '%s'
# Params: Number_of_Sprockets Master_Sprocket_Name
21
Foo Bar Baz

echo '22' > /proc/sprocket
# writes first value if no \n character written before
# close - all writes done simultaneously on close

cat /proc/sprocket | egrep -v '^#'
22
Foo Bar Baz

echo 'Master_Sprocket_Name\nBaz Foo Bar' > /proc/sprocket

cat /proc/sprocket | egrep -v '^#'
22
Baz Foo Bar

echo 'Master_Sprocket_Name\nFoo Foo Foo\nNumber_of_Sprockets\n111' > 
/proc/sprocket
# Simultaneous commit if /proc driver needs it
# i.e. it has get_lock() and release_lock()
# entries
cat /proc/sprocket | egrep -v '^#'
111
Foo Foo Foo

& nice user tools look at the '# Params:' line to find
what number param they want to read / alter.

--
Alex Bligh
