Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbUK0B2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbUK0B2Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbUK0B0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:26:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263058AbUKZTkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:40:36 -0500
Date: Thu, 25 Nov 2004 16:46:10 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041124101854.GA686@elte.hu>
Message-Id: <Pine.OSF.4.05.10411251159520.12827-101000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1949371650-1101397570=:12827"
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1949371650-1101397570=:12827
Content-Type: TEXT/PLAIN; charset=US-ASCII

I finally got time to run the test on 2.6.10-rc2-mm2-V0.7.30-10.
Conclusion: The bound on the locking time seems not to be bounded by 
depth*1ms as predicted: The more blocking tasks there is the higher the
bound is. 
There _is_ some kind of bound in that I don't see wild locking times. The
distributions stops nicely at N *1ms N in is higher than depth.

I have attached the data. The files is named
 <kernel ver>-<depth>.<blocking tasks>.hist
Note especially 
 2.6.10-rc2-mm2-V0.7.30-10-3.20.hist
which is depth 3 and 20 blocking tasks. There is a clean upper bound of
7ms (7.1 to be exact) but where does the 7 come from??? A formula like
N=2*depth+1 might fit the results.

If we understand what is going on this might end up being "good enough" in
the sense it is deterministic. The end result doesn't have to be the best
case formula. But the maximum locking time have to independent of the
number of lower priority tasks banging on the protected region as that is
something uncontrolable. We have to be able to predict a bound based
solely on the depth before we can say it is "good enough".

Esben


On Wed, 24 Nov 2004, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > Results (in short): 
> > -30-9 doesn't resolved nested locking well. The expected max locking time
> > in my test would be depth * 1ms - it is much higher just at a locking
> > depth at two.
> 
> could you check the -30-10 kernel i just uploaded? I fixed the PI bugs
> you reported (and found/fixed other ones as well).
> 
> 	Ingo
> 


--0-1949371650-1101397570=:12827
Content-Type: APPLICATION/octet-stream; name="2.6.10-rc2-mm2-V0.7.30-10.tgz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.OSF.4.05.10411251646100.12827@da410.ifa.au.dk>
Content-Description: 
Content-Disposition: attachment; filename="2.6.10-rc2-mm2-V0.7.30-10.tgz"

H4sIAHX7pUEAA+1dS65kN471OFfxNuCESFGktJGeN3rSPSgU4Kref0skDyNh
t8NAfe5L29LkCfG7Lz6Hn8NDir/qV2o//vRf/ONf/sI//kf7al97+3HfRF/b
1//+n7/9/Yd/ejVqTUV+aLF+/rc14R+o0SBuJkT78d1If/ho//ylf3v979/+
/p8/fXz88NNf//r2rf7W/b/T1b62j7WW0Qf5V/GlfaUPnh/tS9/30P772f/h
Xf/OxW/wTw/hn8wS/0StB/6ZLv6fWIn/Lh+i1tjhr+Nj9CF7zx/tY0izve2+
1bOVuPU8eJxtW+exuq3FkHFutX2rNjrbeR4w59rbdba61pftWfa2D+ZrXD57
vcM/P49/3j8gx3/ni/8nFvCvH9Jb18C/fIwxR+FfBPhXbcD/WAb8d3+s+tZN
gfkDXvgfNoD/sUbif5t4u/j/7PUO//0h/DM14H/7mh7+v138P7GAf/tg6xH9
K+9bJjn8aW+bJvzXdANx4L+/Ucf0iH2nNABr0EgDsGz1NADL/DWOATipRhqA
KaPvLZ1Y4BqCT1rv8C9P4b8V/rfXGIH/6/8fWYl/3fgfPBz/vR/QW7r//d0t
+P/9sJcB4DbTAKzFhX9ZC/ifbQH/6uYk8D8F+NelF/efvN7hfzzv/40k/X+/
+H9ivfg/7jbB/q3lwfvx//uL+TYAQP6/TQYX/PUFf57l/nWU++8z4b9/CWLA
/9SR/p+uHfik9ev450/g/7kN7df/P7he/v8b/r9vx/+FN2Av//9HX+/w/zz/
v1eTwP+t/z2ygP/D/w9P4zf89RB5Dfxfd/feg8hj8H9Grfh/d/rO//Eo/k8M
4b/uLxX8n60J/l/tpv2fvt7h/yn+v++YP/Hflcfl/x9cwP/Y+JcW/H8fp6an
wD85vB3/2zxX/Y808b9Tfgb+iQr/TSb4//29Av8sXPU/NwVO/8khAtlvPOzg
uZbQyRPOpbqdNGH4487uXKh33btzne58wnSDcp67/FVshy/nIrz/ic/+iL/r
9Q7/T/H/XQX4378PDfzbxf8TK/E/5uH/l8Nf+GN//HD/1sdI+NtYlPC32VD+
26FaT/gbF/tv5FHD9KdV+m9zAP7jRBsBf95xReKfZaw0ADxU0wLsK/Q0ASyr
pw3gPjmNAIvbg+mPJU4zsF9hpB2gabK3l2v4+XqH/6f4/+1LgH9Vaxf/Dy7g
f238a4T/Qgf/C/hnAv1nvSP8t2G98O88v+M/qMLA/0D4bzzg/rcFKfwzG9i/
MWfin0bhnwYD/6ROGnqxUQZigP2DscQ/yVyJfxLriX/SNoH/vi1I4n//uvaW
X1u/WrOz9avRvjDH1aifV/CrNVl7a6/H+tXanM6U7O32Xi6aPDQo7d3vorD5
Dv9P8f+jI//vrVP6/3Hx/8R64Z+UJ/BPNIF//7E3YGRW+a/wT811AxrIgf/f
cIH8h8ipgqD/Gen/nA3wX+6x3f3z7Ij/F0nCX81Fg25slraE/zjpSrr/Pi3h
v1QS/YerCPBHGEBhwYB9ZZXEfl9rJvb5JCCJfR0tsc+demJ/f0jAvom0xP7s
vBL7tnx7rjZ/B+TpO/zrY/4f9b9OJub4l6v/fWQl/iXdqet/Dk4HF/7dkQf+
Hd6Jf3rJf7jwL7Pwr/D/20D0wr9p4n9V8Y+5v8L/ZYn/0foC/pczBedikzrC
/6GrAf8H6+n+mRH+24L332lHGgBdQ2AAeltlANwWuAFoIjAAR8uQBqDRhAGg
cv4eD6UB2JECDMCRQKUB+P4Fju/wb4/5f9T/ekf/T7/4f2QB/z3i14P/YR+8
oP7vjl0HSQf31xXSP54I/TtD+H88aAC/M/x+L9GfTpB++7kNrB8paL9hygl7
iwTAYR+8wbmQyirqjzwXcNjPgj3xIkT9G7fl+RuX5/fIwN/TtAbgk6M9gC9a
wF8K4Hd9AZ8K+LxvTeAbA/j7B//dIz/Wr+O/P1f/f+F/nL33/938/5EF/n/+
ov7/2f/ZXU+sd/h/qv7PrfJ/rf6fq/97ZL3wLyo9+v86nUp/1f+6gQAci0EA
7PtR/xtRLIiY3JAAjJNfZ/2vL8j/x8mks/633Dn3KzL6zPUO//wvCgB+A/8k
lPjfbn+nkPvxsk3Axf8TK/CvO/bfmJfU/9hYG+s0YQFshAJo24VtKcoCWCmA
1ujoAGZ5dQA6c+gWQCdSgZ22gwK0yUgGhIdmMiDWiwM0BQcoSs2TAf7YZkog
A5gLJcDTvpzJgIhBCSDs8fu5mtBCMrAfkLlAKAU8FeDgAOmDnS4ce9f9cedt
Hb0BZ9KxMgvozVIkeRKdnhexTAF4ZwZ76xLq7reez29nJCdHEN/uT6r7dfiQ
Jd0vRKud13IKZfh27rdMp9u6+7U8vZFIb2TbYImEQ/rY2yjY8t55vUbO7nx6
U869nkl12Tsv1ui5zWs1fG7zxGZ/hhJ5TetfRhC1a+xdELU7CxvxuTXZOy/T
7n9nRAa1bO8iLTxP8fzJzjOco9kvPaJC288zvEC7v14NZ7B/ehoMjbSdiKlf
ZSrv34L6dSY3OXt/O5P3j1NDfX6yhr33t7SGP9ff1Fz9vOb0N308kMYbU90/
YQsOqq/9u7T4vrr9GbUib+3/4/ovadX/efO/Rxb4n6P/6i7TPFMcjhmv+I9T
ALLvIBNYf1po/9o5e+k/aaIAtL05+j++1X8dZgT6T0IFqE8Y/+6ajx4eAfqv
qv50A/nbu4AEYpR+QkXmdFOH7uPY2M/+iL/r9Q7/T+m/RuV/Quj/7HLx/8RK
/NPaMJtZAJ5nZIuiALxjNwjAdtJX+s8pFf0N7wqL/O+l/1Yu/Ecg6PifjPYv
CfbWfS+BCSbXenqxSVqpP1D9oSr+knZIP5w6nrVzCtgQ9JGXaP0a2jLmY0Hd
h53y9ZhvWZK/PFD0OTEJF6WdMd/oSfweaxMx3ylfffbX+A+vd/h/TP/Vof+S
vqF/8f/ggv5DjnAy6r+iO3NYVPpPZ4UinxDA37SD/jGeaP/cD0AVyEiQ/JkI
4L/tB8Y/jajjeF7RFQKQvW0wAN2gAKcjR0sTQK4QdxvALvpyI9Bb6b/6S/91
ooS0A8RI/oh9y/EKDfqvE+VA/2VVAmaPJKK2bdCA7Fsn9F/sl4i6Ewn0X/O7
131hvcP/Q/qvDX0F/mVk/H/1H88s4P/Mf5kK/fccDe5/9jkz/J+HLQn87ywa
NeC5v8HE/zzsbuB/NgL9O3kB/1NL/zWW1PSXJtB/GOQfnSD+7FTtHw7yqDaX
9MMFY+6aCbgPZx7hv8L9u9gjNGYE99+g+iBXcTrijar0C7yfwnjA/QQqifad
/nRIy5Py2T9eZ3xO8jKd8DlUEznfs3fO5njDDIuzPSe1sSR7hMm5nvM4carn
vB6YnqNpDaJn29XkeY78JXmebbgllTI9eZ7YecF8WPI86nxQSHI1eR6dljzP
EeF+9q/xrqfXO/v/kP6PGpf9V+bo/+23//eRhfqfN9lk9X/tOE1f8Z9W/HeG
9zXPl8xoIf4bL/2/zBr/uQztfzaK/LdDTqP/ZyD+W4z0bxGo/+XdQT5pRGH/
Q+PjjmaB/pml/I2dzxiaCPusVP/SoPvrBvt/7DCnogmq3yPkZdQWkP6JVfoH
3c+JU8P+99kg9rcJ++/Uvl/DiXu3/73sf7ey/yD7++pp/7sLitz+E6f9P51O
sP8Knn8Wz9807f/+qNP+768NPD818Pza0v5PAs9vO7IO+79j/uT571jWP896
Z/8f0n9SK/23mDW6+f+DC/Mfx45yc/6Tyo4ZFQJQ5Q79t44O/beqov9juw30
f2ov/fdYjPhftfTfOgTT32SZVAOIVALQFB6A20D+z0xQgu5bq/+zNZCA3BqK
v/sBDXkADbSA0ImWMxNYVfwtIrAPhSfgDiLQvYhfyJ8bxQaBJyjpdxcGETgF
nsDJwVP7PdRheIJemUAfMz1B9xoxChrpCbg8gYz0BOf/S09QJV9bqPhGTdeL
pF7n9QRtLFR8mavi29MT7JztlxXfUZ5g9fQEvxsa465/cL2z//Mh+08K/ndQ
z/l/N/5/ZqH+Q6eHPvT/c26rMDvif5no/zO14n/nDP5npwJR6HEDcywb+N9Z
/b9a/I/Njv6fMfur/Ivqb7E/E+QP+n4FVl/A+cqr7guxz4K1d7t/Xvr0NHGW
sTSN/ZiUxj5uixq2pbEfE8Z+MFje/b+msVcG7TPaTGN/zjGIsH87yDT2OjWN
/RlyGsZe/XF+DVtp7E9lrEMilcZe20hjP2SlsWeDsT/9h2Hsj7sJY89T09jH
zp3WnGnseYH26QTap7eWxr6LprE/jiLUPZOg7jHX77hDaZTqHnPKyNMwFwn5
1z0s1T3Td+5QJqW6Z7aR6p47fOE7W+/s/3rI/u+QDfa/78de/c+DK+z/XLqD
7BXyn52PRaCOBKBh/puyj3R3syZtvBKAVglADYAZq2P8uzJVAtAXHIDMVQMg
WBcKgMJIAKjPkgBEsTCbs+AKiF0tEAVAmlUAFDgEklcrGM3yCa4O+JlP0A6f
sFAKGNX/vT+Cav9m+AQXlvp7UiQAx7NkKWCiFHCu1pE+wSewpE84niV9ghJ8
gjb4BEYpYCxQQccrpU/QCZ+gKAVwh+STB8MnKEoB7ElBdMyv9Akn6wufcLRS
4RPYQAWdsTnpE0ZLnzBJ4ROopU+Ys6dPMH+G+wTh9AmrQfF55oqnT+hQfF6F
1ieuX7f/8gn9f9vq4Pyvy/88sr6Z/+FfBSaA3JacP8d6h396qv9nQP9tcmqB
3v9z479HluPfdCOedwDo6LehO7zT6P5R40PgBgW8Y7odxVCIQHq3fe9oSQPo
lKKBiSEDUXHKwKPAGAwQEVPRAHMMjAHcv5KBKLDN0oEyVxTI/RUFzpKCGlUU
OIsGpqkoB9JyJUfQwANjALvrvbxYR4gChVdGgdKhB+0GGlgGZoAEW+BiDRsZ
BYbQI4p1WtO/IgbkjABBAFNGf+ADIAKBBKSjAJgxH4p/K+M9GhnuEQp/hP4e
QnuP1w4Nt0xs/AOhjPN2zJwVv+rr6WjrGRnjCdL+jp6e3tDSg46evjK829Fn
RHejgrtG2cwj3poTo504G3niXud3iLOJJ25zhocsG3jiNv9I9r9hqYmhbN05
YbJFsD1Pa48H2+3clpnK3nmiIuc2/8Dbea7/QP1V/Pc5zitHktK+zJhWsW+b
8T7+oEfVvLX//6IG8N+y/1r6XxunF+DY/3v+yzPL7T+Pc/5bdwN+SlY1s5WP
gu6IPYIB4Ln2PSkC7mJnxFLIQHT203EXfUBK86iCQwri96jETBi/R3xUzNow
41NqivMg1bZroRH9oGOdKqT7Aj3NSDESUue+TqgC+zqeKftBB1SBA72gpQk0
lAINHkBHgyRwogxYEuA0/jD9PvRNw3Km8ldLCJhmn2H1j6MLq2+evweZAcM/
YPk5Tb8h7yf3FjnENu0/uy9ZlbGHlNHQ6znLD5jCEbjcL6SMBlfgOX64SEhA
zjzL9Aar3MFk5P3N0Oo50iGs9Acr3UFPb0AMDjidwUhfoOkK0NmpYH5F0xFQ
OQLSlY7gaKfDETBROgJunI7g/K+a1V30cZ53bOnUGT2c3NIRsIx0BKd4azlF
WNIRsJv6YERaOoIde6YjOKLRcASHB5lZ2rV0BGM7lhnE2P4OZzibfh4XdfFz
2ygnonWvO5tx7g326LxexkJfVnxSOvYu+LDxlLd5a/8fn/8xtI07/+vJ9e38
jy6t5n/MWed/GEMAOMzNfZTOGPzv4BKAjO7JgduDmBfmP3YZ1f0f43sjTJ4r
+98v2fBp6x3+n+//HiYW83/kxn+PLPB/p+2L8vwfWWemT/V/0qjzv1ud/znI
Xud/aM3/OWM8cP7HRP1nkHD1fxv6P/si9H92QfknOsFCOAv110n+0P9t1QBS
/d+G/s9eIwBPBp4NIOOKWd+ud/h/qv9bDPVfJaJ+538/uKD/1EN5tQ4B6Ihz
vGP+lxT+her8r75wAMiIom/M5NYSgFKd/zW4jv8dUd7NUTmY/jOh//fKbUzk
BfgZAiCFAAhD/wXDP2vug9SsH9R6X2JP9rpuTPoBy9e5ZP8u53TLMkr27/Xf
WbfBskDs+YeIWt7h/6n+bx3gf3ZQ2cf1/w+ub87/GCvP/zl9mhX+TxVMAJ7B
A3lTThzv46X/Yej/ya5Qp2DY5wO6IkxdWOiSsPUaBKyG/k+u07/g/An6P3fz
AxvFgz1hrxN/Zo19SPj3mvoLjt9K6AHsT+i8J5C/QO9P4H5C4rHQ7EMMbp9a
STy2z2ogemih38cPQ+jZtO5Tv+IYkdJ57KexEz7nvIWxkvE5IljM92rV9vlv
0829w/9T53+Yof6vQhr6L7n1/0cW8K8bTyvGf4rE0dzAPxX+p1X/95oI/6dM
KfyzFP4n0v9pJoX/3gr/CvwTon+G+6/ZT1zn/oDkrcC/BF9chb6K+iekXgl/
uH50eXgb98AmSnCJ/YS+JfIx3BtiX0KL3wvyKwHPhrIe2vuc9g1qN5ldAszZ
qrUbEN8YAa9LvSp8tKDoIjJ09+U2DMrCHL98bMyl8NcNgyID9T5iCLtgUN7h
/6n+XxL0/+pQiv5fufr/Rxbmv8nG3Az6b9uCGTWa0IKvwn8E+jH/odL/GUeF
Ov5f53/YrPkvkxjp/zYQKPwre7nGa6u9Zn96AShGf+IYAKnDP+Ig0GgCICQB
9MoCEAfIQv9vr5N/Bqo9AlswUO4ZI42B4KyvV6Efc58Mcx9Mq96DQZ+EKv9K
i+DTQKPiAIuAgQ+sP7cIbkei1FMtXmkRYv5D/NMQ/Q8v6sTn0tIanJJEGIPh
ncD+uSxNUxCzI4J8QYdX7OJzsaz0qA/yDKEqRP86IPDcMXoWfIaP+QwxLKHo
48/wz6dV4Uftiv6/+/XO/j/V//vq/1LD+a9y9V+PrG/iv66p/jwF+zr+3WTg
+GfTAfm/n3WC+Q8Lw5+t1/yHbQcw/s9Gx/h3s47+X20C4ZfW8Y9mOAfGDKqv
2UAB6cLoL2OQQLbQBmYK+28T1X5jFPtFcPyLLMz8kolj3wZj4tchsFLuVec9
iqLr93Xi23iNfPa2LoLdd0+ANjBCFxhJpYJV94cngNqfMPeBO7T+9MYTSJX8
xUv57gl8roP/97M8ASMojNaB8JAICYeg5H8aH8ITWIMnGBMyMG0KT2CanuCI
6X7hCSYEAOojmsMTCDzBHTH0na139v+p/l82nP9tzfL8r5v/P7Ne81+5S8x/
m8eWCvJ/U63zf1Xr/N9JGP9sQfpF/+9E+d/i1WL+Y81/MK3yn9IC/a8C3a8x
ZL/mPF+MmgQHoNzK/mP+WxwWEG6mxF5caq9V838I89/icK+eNpwrx0j730AH
HhuZ9l/K/hsKASc/SfvfcN4n2oAx8YFy0j9owJr6Bsv/M7kvEgBYfUubvzDd
AUQAzH2JfdHqW+KuXsk/pF3o8hVtaebP3KY084KAXybMvCx0+Q7CDP/hTiAk
HS3N/Ojo8h2MLt+xXaxmRzSl1it26LDT6n7TlIxLar2GtdR6aZ+p9Tpdd1ZJ
RWi9+h9UkPvwemf/n+r/7VT9H9zz/Cfha/+fWGn/2zxnL4f9P+JbrQMgdRT/
s+M4yD90EuY/qE2M/9ZIIfK0RJR/Vb5p/JCa/zBc9OFRYdwailar+b+TwALT
GSWQPLDVAbB7W/N/7XUSpEmNAZ+vOeDDR3274ViYBCeEcyCltL9CqAu9Gj/6
LE/AKA2d9uf0BK0ygRoJ0f9fTxC3f+sJ0PgB4S/m/aACVMe7IPwnCH4Zsx+o
2nwx5ofQ5Esvre/P3YF3dcTMupXu4GQ+I7m3DnfQyx3whDvw7CAK8GgAORlS
yn5lpTuQuXCkC5c7mDjORWmkOzhBhaZ/n3AHCneg7lT8Z1TSX3XRbpwmWtLf
6w7uuuuuu+6666677rrrrrvuuuuuu+6666677rrrrrvuuuuuP/n6Pyfp2cIA
yAAA
--0-1949371650-1101397570=:12827--
