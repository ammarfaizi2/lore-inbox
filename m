Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261741AbSJDWMe>; Fri, 4 Oct 2002 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbSJDWMe>; Fri, 4 Oct 2002 18:12:34 -0400
Received: from 62-241-188-121.dsl.pipex.com ([62.241.188.121]:5125 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261741AbSJDWMZ>; Fri, 4 Oct 2002 18:12:25 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210042225.g94MPhJU012128@darkstar.example.net>
Subject: Re: 2.5.X breaks PS/2 mouse
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 4 Oct 2002 23:25:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021004224547.A49400@ucw.cz> from "Vojtech Pavlik" at Oct 04, 2002 10:45:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, Oct 04, 2002 at 09:52:26PM +0100, jbradford@dial.pipex.com wrote:
> > > > Once booted:
> > > > 
> > > > Hot plugging either the dedicated trackball or a PS/2 mouse generates a message on connection:
> > > 
> > > Good, this is expected.
> > > 
> > > > Just to clarify, I am not trying to use them both at the same time.
> > > 
> > > Not sure if that would work, it might - depends on the notebook keyboard
> > > controller hardware.
> > 
> > I tried it, and it seems to get really confused - constant stream of seemingly random error messages.
> > 
> > > > X also works with the external PS/2 mouse,
> > > 
> > > Good.
> > > 
> > > > but not the dedicated trackball.
> > > 
> > > What are the exact symptoms?
> > 
> > No data at all from it.
> > 
> > > Does gpm work?
> > 
> > No.
> > 
> > > Does cat /dev/psaux work?
> > 
> > It doesn't say No such device, it just hangs, giving no data for the trackball, but works fine for the generic mouse.
> > 
> > > Does cat /dev/input/mice work?
> > 
> > Yes, it does the same as /dev/psaux
> > 
> > > What does cat /proc/bus/input/devices say in the
> > > case it doesn't work? ....
> > 
> > I: Bus=0011 Vendor=0002 Product=0001 Version=0000
> > N: Name="PS/2 Generic Mouse"
> > P: Phys=isa0060/serio1/input0
> > H: Handlers=mouse0
> > B: EV=7
> > B: KEY=70000 0 0 0 0 0 0 0 0
> > B: REL=3
> > 
> > That's for both the generic mouse and the trackball.
> 
> Ok. Can you try the usual #define I8042_DEBUG_IO in
> drivers/input/serio/i8042.h?

OK, here goes, here's a boot of the laptop, with no mouse or trackball connected:

register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: PC Speaker
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [1]
i8042.c: 56 -> i8042 (parameter) [1]
i8042.c: d3 -> i8042 (command) [1]
i8042.c: 5a -> i8042 (parameter) [1]
i8042.c: a5 <- i8042 (return) [1]
i8042.c: a9 -> i8042 (command) [2]
i8042.c: 00 <- i8042 (return) [2]
i8042.c: a7 -> i8042 (command) [3]
i8042.c: 20 -> i8042 (command) [3]
i8042.c: 76 <- i8042 (return) [3]
i8042.c: a8 -> i8042 (command) [4]
i8042.c: 20 -> i8042 (command) [5]
i8042.c: 56 <- i8042 (return) [5]
i8042.c: 60 -> i8042 (command) [6]
i8042.c: 74 -> i8042 (parameter) [6]
i8042.c: 60 -> i8042 (command) [6]
i8042.c: 54 -> i8042 (parameter) [6]
i8042.c: 60 -> i8042 (command) [7]
i8042.c: 56 -> i8042 (parameter) [7]
i8042.c: d4 -> i8042 (command) [8]
i8042.c: f2 -> i8042 (parameter) [8]
i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [27]
i8042.c: 60 -> i8042 (command) [27]
i8042.c: 54 -> i8042 (parameter) [27]
i8042.c: 60 -> i8042 (command) [28]
i8042.c: 56 -> i8042 (parameter) [28]
i8042.c: d4 -> i8042 (command) [29]
i8042.c: ed -> i8042 (parameter) [29]
i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [48]
i8042.c: 60 -> i8042 (command) [48]
i8042.c: 54 -> i8042 (parameter) [48]
serio: i8042 AUX port at 0x60,0x64 irq 12
i8042.c: 60 -> i8042 (command) [50]
i8042.c: 44 -> i8042 (parameter) [50]
i8042.c: 60 -> i8042 (command) [51]
i8042.c: 45 -> i8042 (parameter) [51]
i8042.c: f2 -> i8042 (kbd-data) [52]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [54]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [55]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [57]
i8042.c: 60 -> i8042 (command) [57]
i8042.c: 44 -> i8042 (parameter) [57]
i8042.c: 60 -> i8042 (command) [58]
i8042.c: 45 -> i8042 (parameter) [58]
i8042.c: ed -> i8042 (kbd-data) [59]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [61]
i8042.c: 00 -> i8042 (kbd-data) [62]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [64]
i8042.c: f2 -> i8042 (kbd-data) [65]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [67]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [68]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [73]
i8042.c: f8 -> i8042 (kbd-data) [73]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [75]
i8042.c: f4 -> i8042 (kbd-data) [76]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [78]
i8042.c: ea -> i8042 (kbd-data) [79]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [81]
i8042.c: f0 -> i8042 (kbd-data) [81]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [83]
i8042.c: 02 -> i8042 (kbd-data) [84]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [86]
i8042.c: f0 -> i8042 (kbd-data) [87]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [89]
i8042.c: 00 -> i8042 (kbd-data) [89]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [94]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [96]
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1

Plugging in the trackball gives this:

i8042.c: aa <- i8042 (interrupt, aux, 0) [113024]
i8042.c: 60 -> i8042 (command) [113025]
i8042.c: 47 -> i8042 (parameter) [113025]
i8042.c: 00 <- i8042 (interrupt, aux, 0) [113025]
i8042.c: d4 -> i8042 (command) [113026]
i8042.c: f2 -> i8042 (parameter) [113026]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113030]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [113031]
i8042.c: d4 -> i8042 (command) [113031]
i8042.c: f6 -> i8042 (parameter) [113031]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113035]
i8042.c: d4 -> i8042 (command) [113035]
i8042.c: e8 -> i8042 (parameter) [113035]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113039]
i8042.c: d4 -> i8042 (command) [113039]
i8042.c: 03 -> i8042 (parameter) [113039]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113043]
i8042.c: d4 -> i8042 (command) [113043]
i8042.c: e6 -> i8042 (parameter) [113043]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113047]
i8042.c: d4 -> i8042 (command) [113047]
i8042.c: e6 -> i8042 (parameter) [113047]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113051]
i8042.c: d4 -> i8042 (command) [113051]
i8042.c: e6 -> i8042 (parameter) [113051]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113055]
i8042.c: d4 -> i8042 (command) [113055]
i8042.c: e9 -> i8042 (parameter) [113055]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113059]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [113060]
i8042.c: 03 <- i8042 (interrupt, aux, 12) [113065]
i8042.c: 64 <- i8042 (interrupt, aux, 12) [113066]
i8042.c: d4 -> i8042 (command) [113067]
i8042.c: e8 -> i8042 (parameter) [113067]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113070]
i8042.c: d4 -> i8042 (command) [113071]
i8042.c: 00 -> i8042 (parameter) [113071]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113074]
i8042.c: d4 -> i8042 (command) [113075]
i8042.c: e6 -> i8042 (parameter) [113075]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113078]
i8042.c: d4 -> i8042 (command) [113079]
i8042.c: e6 -> i8042 (parameter) [113079]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113083]
i8042.c: d4 -> i8042 (command) [113083]
i8042.c: e6 -> i8042 (parameter) [113083]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113087]
i8042.c: d4 -> i8042 (command) [113087]
i8042.c: e9 -> i8042 (parameter) [113087]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113091]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [113094]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [113095]
i8042.c: 64 <- i8042 (interrupt, aux, 12) [113096]
i8042.c: d4 -> i8042 (command) [113097]
i8042.c: f3 -> i8042 (parameter) [113097]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113100]
i8042.c: d4 -> i8042 (command) [113101]
i8042.c: c8 -> i8042 (parameter) [113101]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113105]
i8042.c: d4 -> i8042 (command) [113105]
i8042.c: f3 -> i8042 (parameter) [113105]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113109]
i8042.c: d4 -> i8042 (command) [113109]
i8042.c: 64 -> i8042 (parameter) [113109]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113113]
i8042.c: d4 -> i8042 (command) [113113]
i8042.c: f3 -> i8042 (parameter) [113113]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113117]
i8042.c: d4 -> i8042 (command) [113117]
i8042.c: 50 -> i8042 (parameter) [113117]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113121]
i8042.c: d4 -> i8042 (command) [113121]
i8042.c: f2 -> i8042 (parameter) [113121]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113125]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [113126]
input: PS/2 Generic Mouse on isa0060/serio1
i8042.c: d4 -> i8042 (command) [113128]
i8042.c: f3 -> i8042 (parameter) [113128]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113132]
i8042.c: d4 -> i8042 (command) [113132]
i8042.c: 64 -> i8042 (parameter) [113132]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113136]
i8042.c: d4 -> i8042 (command) [113136]
i8042.c: f3 -> i8042 (parameter) [113136]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113140]
i8042.c: d4 -> i8042 (command) [113140]
i8042.c: c8 -> i8042 (parameter) [113140]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113144]
i8042.c: d4 -> i8042 (command) [113144]
i8042.c: e8 -> i8042 (parameter) [113144]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113148]
i8042.c: d4 -> i8042 (command) [113148]
i8042.c: 03 -> i8042 (parameter) [113148]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113152]
i8042.c: d4 -> i8042 (command) [113152]
i8042.c: e6 -> i8042 (parameter) [113152]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113156]
i8042.c: d4 -> i8042 (command) [113156]
i8042.c: ea -> i8042 (parameter) [113156]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113160]
i8042.c: d4 -> i8042 (command) [113160]
i8042.c: f4 -> i8042 (parameter) [113160]
i8042.c: fa <- i8042 (interrupt, aux, 12) [113164]

Moving it around, (looks like some had already been lost from the top of this, I.E. it doesn't follow on directly from above):

i8042.c: 3d <- i8042 (interrupt, aux, 12) [189159]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189165]
i8042.c: 0d <- i8042 (interrupt, aux, 12) [189171]
i8042.c: 2b <- i8042 (interrupt, aux, 12) [189174]
i8042.c: 10 <- i8042 (interrupt, aux, 12) [189182]
i8042.c: f4 <- i8042 (interrupt, aux, 12) [189185]
i8042.c: 48 <- i8042 (interrupt, aux, 12) [189190]
i8042.c: 10 <- i8042 (interrupt, aux, 12) [189195]
i8042.c: cf <- i8042 (interrupt, aux, 12) [189198]
i8042.c: 3e <- i8042 (interrupt, aux, 12) [189201]
i8042.c: 10 <- i8042 (interrupt, aux, 12) [189207]
i8042.c: e6 <- i8042 (interrupt, aux, 12) [189211]
i8042.c: 29 <- i8042 (interrupt, aux, 12) [189214]
i8042.c: 10 <- i8042 (interrupt, aux, 12) [189220]
i8042.c: d1 <- i8042 (interrupt, aux, 12) [189223]
i8042.c: 3e <- i8042 (interrupt, aux, 12) [189227]
i8042.c: 10 <- i8042 (interrupt, aux, 12) [189232]
i8042.c: e1 <- i8042 (interrupt, aux, 12) [189234]
i8042.c: 26 <- i8042 (interrupt, aux, 12) [189235]
i8042.c: 10 <- i8042 (interrupt, aux, 12) [189238]
i8042.c: e8 <- i8042 (interrupt, aux, 12) [189239]
i8042.c: 15 <- i8042 (interrupt, aux, 12) [189241]
i8042.c: 30 <- i8042 (interrupt, aux, 12) [189244]
i8042.c: fc <- i8042 (interrupt, aux, 12) [189246]
i8042.c: f3 <- i8042 (interrupt, aux, 12) [189248]
i8042.c: 30 <- i8042 (interrupt, aux, 12) [189254]
i8042.c: fe <- i8042 (interrupt, aux, 12) [189256]
i8042.c: cb <- i8042 (interrupt, aux, 12) [189259]
i8042.c: 20 <- i8042 (interrupt, aux, 12) [189263]
i8042.c: 01 <- i8042 (interrupt, aux, 12) [189266]
i8042.c: cd <- i8042 (interrupt, aux, 12) [189269]
i8042.c: 20 <- i8042 (interrupt, aux, 12) [189274]
i8042.c: 0a <- i8042 (interrupt, aux, 12) [189275]
i8042.c: d7 <- i8042 (interrupt, aux, 12) [189277]
i8042.c: 20 <- i8042 (interrupt, aux, 12) [189279]
i8042.c: 0a <- i8042 (interrupt, aux, 12) [189280]
i8042.c: f9 <- i8042 (interrupt, aux, 12) [189282]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189284]
i8042.c: 0c <- i8042 (interrupt, aux, 12) [189286]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189289]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189297]
i8042.c: 1f <- i8042 (interrupt, aux, 12) [189300]
i8042.c: 19 <- i8042 (interrupt, aux, 12) [189303]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189310]
i8042.c: 3a <- i8042 (interrupt, aux, 12) [189316]
i8042.c: 3a <- i8042 (interrupt, aux, 12) [189319]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189324]
i8042.c: 36 <- i8042 (interrupt, aux, 12) [189327]
i8042.c: 48 <- i8042 (interrupt, aux, 12) [189331]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189337]
i8042.c: 1b <- i8042 (interrupt, aux, 12) [189340]
i8042.c: 27 <- i8042 (interrupt, aux, 12) [189343]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189348]
i8042.c: 1c <- i8042 (interrupt, aux, 12) [189350]
i8042.c: 47 <- i8042 (interrupt, aux, 12) [189351]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189353]
i8042.c: 02 <- i8042 (interrupt, aux, 12) [189355]
i8042.c: 0f <- i8042 (interrupt, aux, 12) [189359]
i8042.c: 10 <- i8042 (interrupt, aux, 12) [189363]
i8042.c: fd <- i8042 (interrupt, aux, 12) [189364]
i8042.c: 1d <- i8042 (interrupt, aux, 12) [189365]
i8042.c: 10 <- i8042 (interrupt, aux, 12) [189368]
i8042.c: f7 <- i8042 (interrupt, aux, 12) [189369]
i8042.c: 07 <- i8042 (interrupt, aux, 12) [189371]
i8042.c: 10 <- i8042 (interrupt, aux, 12) [189373]
i8042.c: f4 <- i8042 (interrupt, aux, 12) [189374]
i8042.c: 02 <- i8042 (interrupt, aux, 12) [189379]
i8042.c: 30 <- i8042 (interrupt, aux, 12) [189383]
i8042.c: db <- i8042 (interrupt, aux, 12) [189386]
i8042.c: f5 <- i8042 (interrupt, aux, 12) [189389]
i8042.c: 30 <- i8042 (interrupt, aux, 12) [189393]
i8042.c: e1 <- i8042 (interrupt, aux, 12) [189396]
i8042.c: e0 <- i8042 (interrupt, aux, 12) [189400]
i8042.c: 30 <- i8042 (interrupt, aux, 12) [189403]
i8042.c: ed <- i8042 (interrupt, aux, 12) [189405]
i8042.c: db <- i8042 (interrupt, aux, 12) [189407]
i8042.c: 30 <- i8042 (interrupt, aux, 12) [189409]
i8042.c: ff <- i8042 (interrupt, aux, 12) [189411]
i8042.c: ed <- i8042 (interrupt, aux, 12) [189414]
i8042.c: 20 <- i8042 (interrupt, aux, 12) [189418]
i8042.c: 16 <- i8042 (interrupt, aux, 12) [189422]
i8042.c: e2 <- i8042 (interrupt, aux, 12) [189425]
i8042.c: 20 <- i8042 (interrupt, aux, 12) [189429]
i8042.c: 29 <- i8042 (interrupt, aux, 12) [189432]
i8042.c: ed <- i8042 (interrupt, aux, 12) [189435]
i8042.c: 20 <- i8042 (interrupt, aux, 12) [189442]
i8042.c: 29 <- i8042 (interrupt, aux, 12) [189445]
i8042.c: f2 <- i8042 (interrupt, aux, 12) [189448]
i8042.c: 20 <- i8042 (interrupt, aux, 12) [189454]
i8042.c: 3b <- i8042 (interrupt, aux, 12) [189456]
i8042.c: ed <- i8042 (interrupt, aux, 12) [189459]
i8042.c: 20 <- i8042 (interrupt, aux, 12) [189466]
i8042.c: 21 <- i8042 (interrupt, aux, 12) [189469]
i8042.c: fb <- i8042 (interrupt, aux, 12) [189472]
i8042.c: 20 <- i8042 (interrupt, aux, 12) [189479]
i8042.c: 46 <- i8042 (interrupt, aux, 12) [189485]
i8042.c: f5 <- i8042 (interrupt, aux, 12) [189488]
i8042.c: 20 <- i8042 (interrupt, aux, 12) [189494]
i8042.c: 46 <- i8042 (interrupt, aux, 12) [189497]
i8042.c: ff <- i8042 (interrupt, aux, 12) [189500]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189507]
i8042.c: 30 <- i8042 (interrupt, aux, 12) [189509]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189512]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189517]
i8042.c: 4f <- i8042 (interrupt, aux, 12) [189520]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189526]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189530]
i8042.c: 32 <- i8042 (interrupt, aux, 12) [189533]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189536]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189539]
i8042.c: 30 <- i8042 (interrupt, aux, 12) [189541]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189547]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189552]
i8042.c: 50 <- i8042 (interrupt, aux, 12) [189554]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189556]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189559]
i8042.c: 16 <- i8042 (interrupt, aux, 12) [189561]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189563]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189568]
i8042.c: 25 <- i8042 (interrupt, aux, 12) [189570]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189572]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189577]
i8042.c: 24 <- i8042 (interrupt, aux, 12) [189578]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189580]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189582]
i8042.c: 10 <- i8042 (interrupt, aux, 12) [189584]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189585]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189589]
i8042.c: 0e <- i8042 (interrupt, aux, 12) [189591]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189592]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189597]
i8042.c: 19 <- i8042 (interrupt, aux, 12) [189598]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189599]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189602]
i8042.c: 0a <- i8042 (interrupt, aux, 12) [189603]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189604]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189607]
i8042.c: 09 <- i8042 (interrupt, aux, 12) [189611]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189612]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189616]
i8042.c: 0e <- i8042 (interrupt, aux, 12) [189618]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189619]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189622]
i8042.c: 05 <- i8042 (interrupt, aux, 12) [189623]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189624]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189627]
i8042.c: 04 <- i8042 (interrupt, aux, 12) [189628]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189632]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189636]
i8042.c: 06 <- i8042 (interrupt, aux, 12) [189638]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [189639]

Pressing the left button, then the right button, (this is complete, and follows the above immediately):

i8042.c: 01 <- i8042 (interrupt, aux, 12) [230409]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [230410]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [230411]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [230548]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [230552]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [230554]
i8042.c: 02 <- i8042 (interrupt, aux, 12) [231505]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [231506]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [231507]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [231694]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [231695]
i8042.c: 00 <- i8042 (interrupt, aux, 12) [231696]

So, it definitely seems to be sending data to the port...  Strange...

John.
