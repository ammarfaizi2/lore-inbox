Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129435AbRBYRcp>; Sun, 25 Feb 2001 12:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRBYRcg>; Sun, 25 Feb 2001 12:32:36 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:53000 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129435AbRBYRcZ>; Sun, 25 Feb 2001 12:32:25 -0500
Date: Sun, 25 Feb 2001 18:32:01 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: mason@suse.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs: still problems with tail conversion
Message-ID: <20010225183201.D866@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010223221856.A24959@arthur.ubicom.tudelft.nl> <730960000.982966246@tiny> <20010223231949.D24959@arthur.ubicom.tudelft.nl> <20010225173752.A866@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010225173752.A866@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Sun, Feb 25, 2001 at 05:37:52PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 25, 2001 at 05:37:52PM +0100, Erik Mouw wrote:
> I upgraded to 2.4.2, and initially I couldn't reproduce the problem.
> Besides the kernel version difference, another difference was the fact
> that I did the 2.4.2. test on a freshly booted system, while the
> 2.4.2-pre4 test was done on a system with quite some VM pressure:
> uptime a couple of days, running acroread, netscape, xemacs, couple of
> gnome-terminals with large scroll back buffers (10000 lines).
> 
> John Adams told me that the data didn't hit the disk on his system and
> that he had to add O_SYNC to the open()s. After I did that, I could
> reproduce the problem on linux-2.4.2, with the strange results that the
> bug is in *every* file with initial size >=1024 bytes.

Hohum, this is probably because I forgot to close() the file in the
read() part of the test... *blush*

I just reran the test on my laptop (arthur: Celeron (Coppermine) 500,
128MB, SuSE 7.0 + updates, linux-2.4.2, gcc-2.95.2) and got "only" 963
errors. I also ran the test om my desktop (zaphod: AMD K6-3D/333,
160MB, Debian 2.2 + updates, linux-2.4.2-pre4+reiserfs patch,
gcc-2.95.2) and got 888 errors.

An interesting observation is that the two systems have the bugs in
almost the same places. Attached is a diff between the output files of
both systems.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reiserdiff.txt"

--- arthur-test3.txt	Sun Feb 25 18:17:14 2001
+++ zaphod-test1.txt	Sun Feb 25 18:26:40 2001
@@ -1,7 +1,6 @@
 Creating 8192 files ... done
 Appending to the files ... done
 Checking files for null bytes ...
-  reiser-00039.test contains null bytes
   reiser-00129.test contains null bytes
   reiser-00178.test contains null bytes
   reiser-00219.test contains null bytes
@@ -583,7 +582,7 @@
   reiser-05080.test contains null bytes
   reiser-05087.test contains null bytes
   reiser-05094.test contains null bytes
-  reiser-05100.test contains null bytes
+  reiser-05101.test contains null bytes
   reiser-05108.test contains null bytes
   reiser-05115.test contains null bytes
   reiser-05122.test contains null bytes
@@ -676,98 +675,13 @@
   reiser-05722.test contains null bytes
   reiser-05724.test contains null bytes
   reiser-05726.test contains null bytes
-  reiser-05784.test contains null bytes
-  reiser-05786.test contains null bytes
-  reiser-05824.test contains null bytes
-  reiser-05826.test contains null bytes
-  reiser-05864.test contains null bytes
-  reiser-05906.test contains null bytes
-  reiser-06014.test contains null bytes
-  reiser-06016.test contains null bytes
-  reiser-06018.test contains null bytes
-  reiser-06020.test contains null bytes
-  reiser-06022.test contains null bytes
-  reiser-06024.test contains null bytes
-  reiser-06026.test contains null bytes
-  reiser-06028.test contains null bytes
-  reiser-06030.test contains null bytes
-  reiser-06032.test contains null bytes
-  reiser-06034.test contains null bytes
-  reiser-06036.test contains null bytes
-  reiser-06038.test contains null bytes
-  reiser-06040.test contains null bytes
-  reiser-06042.test contains null bytes
-  reiser-06044.test contains null bytes
-  reiser-06046.test contains null bytes
-  reiser-06048.test contains null bytes
-  reiser-06050.test contains null bytes
-  reiser-06052.test contains null bytes
-  reiser-06054.test contains null bytes
-  reiser-06056.test contains null bytes
-  reiser-06058.test contains null bytes
-  reiser-06060.test contains null bytes
-  reiser-06063.test contains null bytes
-  reiser-06065.test contains null bytes
-  reiser-06067.test contains null bytes
-  reiser-06069.test contains null bytes
-  reiser-06071.test contains null bytes
-  reiser-06073.test contains null bytes
-  reiser-06075.test contains null bytes
-  reiser-06077.test contains null bytes
-  reiser-06079.test contains null bytes
-  reiser-06081.test contains null bytes
-  reiser-06083.test contains null bytes
-  reiser-06085.test contains null bytes
-  reiser-06088.test contains null bytes
-  reiser-06090.test contains null bytes
-  reiser-06092.test contains null bytes
-  reiser-06094.test contains null bytes
-  reiser-06096.test contains null bytes
-  reiser-06098.test contains null bytes
-  reiser-06100.test contains null bytes
-  reiser-06102.test contains null bytes
-  reiser-06104.test contains null bytes
-  reiser-06106.test contains null bytes
-  reiser-06109.test contains null bytes
-  reiser-06111.test contains null bytes
-  reiser-06113.test contains null bytes
-  reiser-06115.test contains null bytes
-  reiser-06117.test contains null bytes
-  reiser-06119.test contains null bytes
-  reiser-06121.test contains null bytes
-  reiser-06123.test contains null bytes
+  reiser-05764.test contains null bytes
+  reiser-05766.test contains null bytes
+  reiser-05804.test contains null bytes
+  reiser-05844.test contains null bytes
+  reiser-05866.test contains null bytes
   reiser-06126.test contains null bytes
   reiser-06128.test contains null bytes
-  reiser-06130.test contains null bytes
-  reiser-06132.test contains null bytes
-  reiser-06134.test contains null bytes
-  reiser-06136.test contains null bytes
-  reiser-06138.test contains null bytes
-  reiser-06141.test contains null bytes
-  reiser-06143.test contains null bytes
-  reiser-06145.test contains null bytes
-  reiser-06147.test contains null bytes
-  reiser-06149.test contains null bytes
-  reiser-06151.test contains null bytes
-  reiser-06154.test contains null bytes
-  reiser-06156.test contains null bytes
-  reiser-06158.test contains null bytes
-  reiser-06160.test contains null bytes
-  reiser-06162.test contains null bytes
-  reiser-06164.test contains null bytes
-  reiser-06167.test contains null bytes
-  reiser-06169.test contains null bytes
-  reiser-06171.test contains null bytes
-  reiser-06173.test contains null bytes
-  reiser-06175.test contains null bytes
-  reiser-06178.test contains null bytes
-  reiser-06180.test contains null bytes
-  reiser-06182.test contains null bytes
-  reiser-06184.test contains null bytes
-  reiser-06186.test contains null bytes
-  reiser-06189.test contains null bytes
-  reiser-06191.test contains null bytes
-  reiser-06193.test contains null bytes
   reiser-06195.test contains null bytes
   reiser-06198.test contains null bytes
   reiser-06200.test contains null bytes
@@ -832,7 +746,6 @@
   reiser-06339.test contains null bytes
   reiser-06342.test contains null bytes
   reiser-06344.test contains null bytes
-  reiser-06347.test contains null bytes
   reiser-06349.test contains null bytes
   reiser-06352.test contains null bytes
   reiser-06354.test contains null bytes
@@ -947,7 +860,6 @@
   reiser-06668.test contains null bytes
   reiser-06671.test contains null bytes
   reiser-06674.test contains null bytes
-  reiser-06677.test contains null bytes
   reiser-06680.test contains null bytes
   reiser-06683.test contains null bytes
   reiser-06684.test contains null bytes
@@ -961,7 +873,20 @@
   reiser-06702.test contains null bytes
   reiser-06703.test contains null bytes
   reiser-06706.test contains null bytes
+  reiser-06707.test contains null bytes
   reiser-06710.test contains null bytes
   reiser-06711.test contains null bytes
+  reiser-06717.test contains null bytes
+  reiser-06718.test contains null bytes
+  reiser-06719.test contains null bytes
+  reiser-06720.test contains null bytes
+  reiser-06721.test contains null bytes
+  reiser-06722.test contains null bytes
+  reiser-06723.test contains null bytes
+  reiser-06724.test contains null bytes
+  reiser-06725.test contains null bytes
+  reiser-06726.test contains null bytes
+  reiser-06727.test contains null bytes
+  reiser-06728.test contains null bytes
   reiser-07077.test contains null bytes
 Checking done

--y0ulUmNC+osPPQO6--
